require 'fileutils'
require 'targz'

WORLD_OPS = %W(chrislloyd whatupdave)

class LocalWorld
  class << self
    def server_properties world, port
      { "allow-flight"     => false,
        "allow-nether"     => true,
        "level-name"       => world['_id'].to_s,
        "level-seed"       => world['seed'].to_s,
        "max-players"      => 1000,
        "online-mode"      => (world['online_mode'].nil? ? true : world['online_mode']).to_s,
        "difficulty"       => world['difficulty'].to_s,
        "gamemode"         => world['game_mode'].to_s,
        "pvp"              => (world['pvp'] || false).to_s,
        "server-ip"        => "0.0.0.0",
        "server-port"      => port,
        "spawn-animals"    => (world['spawn_animals'] || false).to_s,
        "spawn-monsters"   => (world['spawn_monsters'] || false).to_s,
        "view-distance"    => 10,
        "white-list"       => false
      }.map {|values| values.join('=')}.join("\n")
    end
    
    def mongo_worlds
      MinefoldDb.connection['worlds']
    end
    
    def mongo_world world_id
      mongo_worlds.find_one('_id' => BSON::ObjectId(world_id))
    end

    def prepare world_id, port
      puts "preparing local world:#{world_id}"

      world_path = "#{WORLDS}/#{world_id}"
      properties_path = "#{world_path}/server.properties"
      
      # create world path if it aint there
      FileUtils.mkdir_p world_path
      
      # download latest server jar
      `curl -L https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft_server.jar -o '#{world_path}/server.jar'`

      # get world from db
      world = mongo_world world_id

      # check s3 for world
      archived_world = Storage.new.worlds.files.get("#{world_id}.tar.gz")
      if archived_world
        new_world = false
        FileUtils.mkdir_p "#{ROOT}/backups"
        archive = "#{ROOT}/backups/#{world_id}.tar.gz"
        File.open(archive, "w") do |tar|
          tar.write archived_world.body
        end
        Dir.chdir WORLDS do
          TarGz.new.extract archive
        end
      else
        new_world = true
        puts "New world"
      end

      # create server.properties
      File.open(properties_path, 'w') do |file| 
        properties = server_properties(world, port)
        p "settings", properties
        
        file.puts properties
      end

      # create ops.txt
      ops = WORLD_OPS | op_usernames(world)

      if File.exists? "#{world_path}/ops.txt"
        File.open("#{world_path}/ops.txt") do |file|
          ops = ops | file.read.split("\n")
        end
      end

      File.open("#{world_path}/ops.txt", "w") do |file|
        file.puts ops.join("\n")
        file.puts
      end
      
      # remove banned-players.txt
      FileUtils.rm_f("#{world_path}/banned-players.txt")

      # clear server log
      server_log = File.join(world_path, "server.log")
      File.open(server_log, "w") {|file| file.print }

      puts "finished preparing local world:#{world_id}"
    end
    
    def op_ids world
      [world['creator_id']] + 
       world['memberships'].
         select {|m| m['role'] == 'op' }.
            map {|m| m['user_id']}
    end
    
    def op_usernames world
      MinefoldDb.connection['users'].
        find('_id' => { '$in' => op_ids(world) }).
        map {|u| u['username']}
    end
  end

  attr_reader :id

  def initialize id
    @id = id
  end

  def world_path
    "#{WORLDS}/#{id}"
  end

  def set_last_backup backup_time
    puts "setting world:#{id} backup:#{file}"
    MinefoldDb.connection['worlds'].update({'_id' => BSON::ObjectId(id)}, {'$set' => {'backed_up_at' => backup_time}})
  end

  def backup!
    puts "Starting backup"
    FileUtils.mkdir_p "#{ROOT}/backups"

    world_archive = "#{ROOT}/backups/#{id}.tar.gz"

    # having this file present lets others know there is a backup in process
    FileUtils.touch world_archive

    # tar gz world
    Dir.chdir WORLDS do
      puts "Archiving #{world_path} to #{world_archive}"
      result = TarGz.new.archive id, world_archive, exclude:'server.jar'
      puts result unless $?.exitstatus == 0
    end
    raise "error archiving world" unless $?.exitstatus == 0

    directory = Storage.new.worlds

    backup_time = Time.now
    backup_file = "#{id}.#{backup_time.to_i}.tar.gz"
    retries = 10
    begin
      # TODO: stop storing this file
      File.open(world_archive) do |world_archive_file|
        puts "Uploading #{retries}"
        file = directory.files.create(
          :key    => "#{id}.tar.gz",
          :body   => world_archive_file,
          :public => false
        )
      end

      File.open(world_archive) do |world_archive_file|
        puts "Uploading #{retries}"
        file = directory.files.create(
          :key    => backup_file,
          :body   => world_archive_file,
          :public => false
        )
      end

      set_last_backup backup_time

      FileUtils.rm_f world_archive
    rescue => e
      puts "UPLOAD ERROR: #{e.message}\n#{e.backtrace}"
      retry if (retries -= 1) > 0
    end

    puts "Finished backup"
  end

end