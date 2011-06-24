WORLDS_ROOT = File.expand_path "../../worlds", __FILE__
PID_PATH = "#{ENV['HOME']}/.god/pids"

class Worlds
  def self.process_running? pid
    begin
      Process.getpgid pid.to_i
      true
    rescue Errno::ESRCH
      false
    end
  end

  def self.present
    Dir["#{PID_PATH}/minecraft-*.pid"].map do |pid_file|
      pid = File.read(pid_file)
      pid_file =~ /minecraft-(\w+)/
      world_name= $1
      properties_file = "#{WORLDS_ROOT}/#{world_name}/server.properties"
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
end