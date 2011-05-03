#!/usr/bin/env ruby

require 'eventmachine'

SERVER_ROOT = File.expand_path File.join(File.dirname(__FILE__), "minecraft_server")

class MinefoldServer
  attr_reader :users
  
  def initialize options = {}
    @options = {
      timeout: 5 * 60
    }.merge options
    @users = {}
  end
  
  def start
    IO.popen("cd '#{SERVER_ROOT}' && java -Xmx1024M -Xms1024M -jar 'minecraft_server.jar' nogui 2>&1") do |io|
      while line = io.gets
        puts line
        match = line.match /(\d{4}-\d{2}-\d{2}) (\d{2}:\d{2}:\d{2}) \[(\w+)\] (.*)$/
        parse_message match[4] if match
      end
    end
  end
  
  def user_connected name, id, address
    @users[name] = { name:name, id:id, address:address }
    puts "(#{@users.size} users) #{name} connected  id: #{id}  ip:#{address}"
  end
  
  def user_disconnected name
    @users.delete name
    puts "(#{@users.size} users) #{name} disconnected"
  end
  
  def parse_message message
    case message
    when /Done/
      puts "Server started"
    when /^(\w+) \[([^\]]+)\] logged in with entity id (\d+)/
      user_connected $1, $3, $2
    when /^(\w+) lost connection/
      user_disconnected $1
    when /Kicking (\w+)/
      user_disconnected $1
    end
  end
end

MinefoldServer.new.start

