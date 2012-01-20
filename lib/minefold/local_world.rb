require 'fileutils'
require 'targz'

WORLD_OPS = %W(chrislloyd whatupdave)
SERVER_JAR = 'https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft_server.jar'

class LocalWorld
  class << self
    def server_properties world, level_name, port
      { "allow-flight"     => false,
        "allow-nether"     => true,
        "level-name"       => level_name,
        "level-seed"       => world['seed'].to_s,
        "level-type"       => world['level_type'] || 'DEFAULT',
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
      }
    end
    
    def mongo_worlds
      MinefoldDb.connection['worlds']
    end
    
    def mongo_world world_id
      mongo_worlds.find_one('_id' => BSON::ObjectId(world_id))
    end

    def prepare world_id, port
      puts "preparing local world:#{world_id}"

      
      # get world from db
      world = mongo_world world_id

      # check s3 for world
      backup_file = world['world_data_file'] || "#{world_id}.tar.gz"
      archived_world = Storage.new.worlds.files.get(backup_file)
      level_name = 'level'
      world_path = "#{WORLDS}/#{world_id}"
      FileUtils.mkdir_p world_path
      
      if archived_world
        backup_dir = "#{ROOT}/backups"
        FileUtils.mkdir_p backup_dir
        archive = "#{backup_dir}/#{world_id}.tar.gz"
        File.open(archive, "w") {|tar| tar.write archived_world.body }
        TarGz.new.extract backup_dir, archive
        
        # find world and level dirs
        level_dir = File.dirname(`find #{backup_dir} -iname level\.dat | head -n1`.strip)
        extracted_world_dir = File.dirname level_dir
        level_name = File.basename level_dir
          
        # move to world_path
        puts "extracted world dir:#{extracted_world_dir} => #{world_path}"
        FileUtils.rm_rf world_path
        FileUtils.mv extracted_world_dir, world_path

        puts "using existing world backup:#{backup_file} level_data:#{world_path}/#{level_name}"
      else
        puts "no backup found for:#{backup_file} creating new world data"
      end
      
      # create server.properties
      properties_path = "#{world_path}/server.properties"
      File.open(properties_path, 'w') do |file| 
        properties = server_properties(world, level_name, port).map {|values| values.join('=')}
        puts "world settings #{properties.join ' '}"
        file.puts properties.join "\n"
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
      
      # download latest server jar
      download_server "#{world_path}/server.jar"

      puts "finished preparing local world:#{world_id}"
    end
    
    def download_server local_file
      puts `curl --silent --show-error -RL #{SERVER_JAR} -o '#{local_file}'`
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

  def set_last_backup backup_file, backup_time
    puts "backed up world:#{id} file:#{backup_file} time:#{backup_time.to_i}"
    MinefoldDb.connection['worlds'].update(
      {'_id' => BSON::ObjectId(id)}, 
      {'$set' => {
        'backed_up_at'    => backup_time,
        'world_data_file' => backup_file
      }}
    )
  end

  def backup!
    puts "Starting backup"
    FileUtils.mkdir_p "#{ROOT}/backups"

    world_archive = "#{ROOT}/backups/#{id}.tar.gz"

    # having this file present lets others know there is a backup in process
    FileUtils.touch world_archive

    # tar gz world
    puts "Archiving #{world_path} to #{world_archive}"
    result = TarGz.new.archive WORLDS, id, world_archive, exclude:'server.jar'
    puts result unless $?.exitstatus == 0
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

      set_last_backup backup_file, backup_time

      FileUtils.rm_f world_archive
    rescue => e
      puts "UPLOAD ERROR: #{e.message}\n#{e.backtrace}"
      retry if (retries -= 1) > 0
    end

    puts "Finished backup"
  end

end