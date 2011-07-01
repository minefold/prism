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
        port: port,
        god_name: "minecraft-#{world_id}"
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
    @worker = worker
    worlds.each {|w| w.worker = worker; self << w }
  end

  def start world_id
    uri = URI.parse worker.url
    res = Net::HTTP.start(uri.host, uri.port) {|http| http.get("/worlds/create?id=#{world_id}") }
    res.body

    res = Net::HTTP.start(uri.host, uri.port) {|http| http.get("/worlds/#{world_id}") }
    server_info = JSON.parse(res.body)
    world = World.new server_info["id"], server_info["port"]
    world.worker = worker
    world
  end


end