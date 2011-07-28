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
    puts "Archiving"
    Dir.chdir "#{ROOT}/worlds" do
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