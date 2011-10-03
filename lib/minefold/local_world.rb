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
        "online-mode"      => true,
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

    def prepare world_id, port
      puts "preparing local world:#{world_id}"
      `#{BIN}/download-server` unless File.exists? JAR

      world_path = "#{WORLDS}/#{world_id}"
      properties_path = "#{world_path}/server.properties"
      god_config = "#{world_path}/world.god"

      # create world path if it aint there
      FileUtils.mkdir_p world_path

      # get world from db
      worlds = MinefoldDb.connection['worlds']
      world = worlds.find_one({'_id' => BSON::ObjectId(world_id)})

      # check s3 for world
      archived_world = Storage.new.worlds.files.get("#{world_id}.tar.gz")
      if archived_world
        FileUtils.mkdir_p "#{ROOT}/backups"
        archive = "#{ROOT}/backups/#{world_id}.tar.gz"
        File.open(archive, "w") do |tar|
          tar.write archived_world.body
        end
        Dir.chdir WORLDS do
          TarGz.new.extract archive
        end
      else
        puts "New world"
      end

      # symlink server
      FileUtils.ln_s JAR, world_path unless File.exist? "#{world_path}/server.jar"

      # create server.properties
      File.open(properties_path, 'w') {|file| file.puts server_properties(world, port) }

      # create ops.txt
      File.open("#{world_path}/ops.txt", 'w') {|file| file.puts WORLD_OPS.join("\n") }

      # clear server log
      server_log = File.join(world_path, "server.log")
      File.open(server_log, "w") {|file| file.print }
      
      puts "finished preparing local world:#{world_id}"
    end
  end

  attr_reader :id

  def initialize id
    @id = id
  end

  def world_path
    "#{WORLDS}/#{id}"
  end

  def backup_in_progress?
    File.exists? "#{ROOT}/backups/#{id}.tar.gz"
  end

  def cancel_backup
    FileUtils.rm "#{ROOT}/backups/#{id}.tar.gz"
  end

  def backup!
    puts "Starting backup"
    FileUtils.mkdir_p "#{ROOT}/backups"

    world_archive = "#{ROOT}/backups/#{id}.tar.gz"

    # having this file present lets others know there is a backup in process
    FileUtils.touch world_archive

    # tar gz world
    Dir.chdir "#{ROOT}/worlds" do
      puts "Archiving #{ROOT}/worlds/#{id} to #{world_archive}"
      result = TarGz.new.archive id, world_archive, exclude:'server.jar'
      puts result unless $?.exitstatus == 0
    end
    raise "error archiving world" unless $?.exitstatus == 0

    directory = Storage.new.worlds

    puts "Uploading"
    file = directory.files.create(
      :key    => "#{id}.tar.gz",
      :body   => File.open(world_archive),
      :public => false
    )

    FileUtils.rm world_archive
    puts "Finished backup"
  end

end