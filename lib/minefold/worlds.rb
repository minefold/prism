require 'fileutils'
require 'erb'
require 'file/tail'
require 'net/http'
require 'json'


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
  
  attr_reader :worker
  
  def initialize worker, worlds = []
    worlds.each {|w| w.worker = worker; self << w }
  end
  
  def start world_name
    uri = URI.parse worker.url
    res = Net::HTTP.start(uri.host, uri.port) {|http| http.get("/worlds/create?id=#{world_name}") }
    server_info = JSON.parse(res.body)
    World.new server_info["name"], server_info["port"]
  end
  
  
end