require 'fileutils'
require 'targz'

class LocalWorlds
  def self.process_running? pid
    begin
      Process.getpgid pid.to_i
      true
    rescue Errno::ESRCH
      false
    end
  end

  def self.present
    Dir["#{PIDS}/minecraft-*.pid"].map do |pid_file|
      pid = File.read(pid_file)
      pid_file =~ /minecraft-(\w+)/
      world_id = $1
      properties_file = "#{WORLDS}/#{world_id}/server.properties"
      server_properties = File.read properties_file if File.exists? properties_file
      server_properties =~ /port\=(\d+)/
      port = $1

      {
        pid_file: pid_file,
        pid: pid,
        id: world_id,
        running: process_running?(pid),
        port: port
      }
    end
  end

  def self.running
    present.select {|w| w[:running] }
  end

  def self.next_available_port
    running_world_with_highest_port = running.sort_by{|w| w[:port].to_i }.last
    if running_world_with_highest_port
      running_world_with_highest_port[:port].to_i + 1
    else
      4000
    end
  end
end

class LocalWorld
  class << self
    include GodHelpers
    
    def server_properties world_id, port
      col = MinefoldDb.connection['worlds']

      p "world_id:#{world_id}"

      options = col.find_one({'_id' => BSON::ObjectId(world_id)})['options']

      options.merge({
        "allow-flight"     => false,
        "allow-nether"     => true,
        "level-name"       => world_id,
        "level-seed"       => '',
        "max-players"      => 255,
        "online-mode"      => true,
        "pvp"              => true,
        "server-ip"        => "0.0.0.0",
        "server-port"      => port,
        "spawn-animals"    => true,
        "spawn-monsters"   => true,
        "view-distance"    => 10,
        "white-list"       => false
      }).map {|values| values.join('=')}.join("\n")
    end
    
    def start world_id, min_heap_size = 512, max_heap_size = 2048
      if LocalWorlds.running.any? {|w| w[:id] == world_id }
        puts "World already running"
        return
      end

      `#{BIN}/download-server` unless File.exists? JAR

      puts "Starting world #{world_id}"

      world_path = "#{WORLDS}/#{world_id}"
      properties_path = "#{world_path}/server.properties"
      god_config = "#{world_path}/world.god"

      # create world path if it aint there
      FileUtils.mkdir_p world_path

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

      # get a port number to use
      port = LocalWorlds.next_available_port

      # create server.properties
      p "world_id:#{world_id}"
      File.open(properties_path, 'w') {|file| file.puts server_properties(world_id, port) }

      # create world.god
      template = ERB.new File.read "#{LIB}/world.god.erb"
      File.open(god_config, 'w') {|file| file.puts template.result(binding) }

      # clear server log
      server_log = File.join(world_path, "server.log")
      File.open(server_log, "w") {|file| file.print }

      puts "starting server on port #{port}"
      god_start god_config, world_id

      puts "Waiting for server init"
      Timeout::timeout(10) do
        until LocalWorlds.running.any? {|lw| lw[:id] == world_id }
          sleep 1
        end
      end

      puts "Waiting for server ready"
      begin
        Timeout::timeout(4 * 60) do
          File::Tail::Logfile.open(server_log) do |log|
            log.max_interval = 0.1
            log.interval = 0.1

            log.tail { |line| puts line; raise File::Tail::BreakException if line =~ /Done/ }
          end
        end
      rescue File::Tail::BreakException
      end
    end
  end
  
  attr_reader :id
  
  def initialize id
    @id = id
  end
  
  def backup
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
  
end