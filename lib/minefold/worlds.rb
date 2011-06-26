require 'fileutils'
require 'erb'
require 'file/tail'

class Worlds < Array
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
      world_name= $1
      properties_file = "#{WORLDS}/#{world_name}/server.properties"
      server_properties = File.read properties_file if File.exists? properties_file
      server_properties =~ /port\=(\d+)/
      port = $1

      {
        pid_file: pid_file,
        pid: pid,
        name: world_name,
        running: process_running?(pid),
        port: port,
        god_name: "minecraft-#{world_name}"
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
  
  def initialize worker, worlds
    worlds.each {|w| w.worker = worker; self << w }
  end
  
  def start world_name
    puts "Starting world #{world_name}"
    `#{BIN}/download-server` unless File.exists? JAR

    world_path = File.join WORLDS, world_name
    properties_path = File.join world_path, "server.properties"

    # create world path if it aint there
    FileUtils.mkdir_p world_path

    # check s3 for world
    archived_world = Storage.new.worlds.files.get("#{world_name}.tar.gz")
    if archived_world
      FileUtils.mkdir_p "#{ROOT}/backups"
      archive = "#{ROOT}/backups/#{world_name}.tar.gz"
      puts "Retrieved world"
      File.open(archive, "w") do |tar|
        tar.write archived_world.body
      end
      Dir.chdir WORLDS do
        `tar -xzf '#{archive}'`
      end
    else
      puts "New world"
    end

    # symlink server
    FileUtils.ln_s JAR, world_path unless File.exist? "#{world_path}/server.jar"

    # get a port number to use
    port = Worlds.next_available_port
    
    world = World.new world_name, port

    # create server.properties
    File.open(properties_path, 'w') {|file| file.puts world.server_properties }

    # create world.god
    template = ERB.new File.read "#{LIB}/world.god.erb"
    File.open(world.god_path, 'w') {|file| file.puts template.result(binding) }

    # clear server log
    server_log = File.join(world_path, "server.log")
    File.open(server_log, "w") {|file| file.print }

    world.start
    
    # wait for start
    Timeout::timeout(180) do
      File::Tail::Logfile.open(server_log) do |log|
        log.max_interval = 0.1
        log.interval = 0.1

        log.tail { |line| puts line; raise File::Tail::BreakException if line =~ /Done/ }
      end
    end
    
    world
  end
end