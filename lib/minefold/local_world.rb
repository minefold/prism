require 'fileutils'
require 'targz'

WORLD_OPS = %W(chrislloyd whatupdave)

class LocalWorld
  class << self
    include GodHelpers

    def present
      Dir["#{PIDS}/minecraft-*.pid"].map do |pid_file|
        pid_file =~ /minecraft-(\w+)/
        world_id = $1

        LocalWorld.new world_id
      end
    end

    def running
      present.select {|w| w.state == :running }
    end

    def next_available_port
      running_world_with_highest_port = running.sort_by{|w| w.port }.last
      if running_world_with_highest_port
        running_world_with_highest_port.port + 1
      else
        4000
      end
    end

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

    def find id
      pid_file = "#{PIDS}/minecraft-#{id}.pid"
      if File.exists? pid_file
        LocalWorld.new id
      end
    end

    def prepare world_id, port
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
        puts "Retrieved world"
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
    end
  end

  include GodHelpers

  attr_reader :id

  def initialize id
    @id = id
  end

  def world_path
    "#{WORLDS}/#{id}"
  end

  def stdin
    "#{world_path}/world.stdin"
  end

  def server_log
    "#{world_path}/server.log"
  end

  def pid_file
    "#{PIDS}/minecraft-#{id}.pid"
  end

  def pid
    File.read(pid_file) if File.exists? pid_file
  end

  def state
    if pid
      begin
        Process.getpgid pid.to_i
        :running
      rescue Errno::ESRCH
        :stopped
      end
    else
      :stopped
    end
  end

  def port
    properties_file = "#{WORLDS}/#{id}/server.properties"
    if File.exists? properties_file
      server_properties = File.read properties_file
      server_properties =~ /port\=(\d+)/
      ($1).to_i
    end
  end

  def stop!
    puts "stopping #{id}"
    god_stop id

    puts "Waiting for world to stop"
    while state == :running; end
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
  end

  def to_hash
    {
      pid_file: pid_file,
      pid: pid,
      id: id,
      running: state == :running,
      port: port
    }
  end

  def to_json
    to_hash.to_json
  end

end