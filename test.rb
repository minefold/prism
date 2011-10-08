#!/usr/bin/env ruby
# encoding: UTF-8
require 'bundler/setup'
Bundler.require :default

$:.unshift File.join File.dirname(__FILE__), 'lib'
require 'minefold'
require 'widget'
require 'eventmachine/popen3'
require 'prism/back'

module Process
  def self.alive?(pid)
    begin
      Process.kill(0, pid)
      true
    rescue Errno::ESRCH
      false
    end
  end
end


module WorldProcessWatcher
  attr_reader :world_id, :stdout
  
  def initialize world_id, stdout
    @world_id, @stdout = world_id, stdout
  end
  
  def post_init
    EM.file_tail stdout do |ft, line|
      puts "> #{line}"
    end
  end
  
  def process_exited
    puts 'exited'
  end
end

def spawn_detached dir, cmd
  process = fork do
    Dir.chdir dir
    exec cmd
  end
  Process.detach process
end

def spawn_world world_id
  world_path = "#{WORLDS}/#{world_id}"
  pid_file = "#{PID_PATH}/#{world_id}"
  
  FileUtils.mkdir_p PID_PATH
  spawn_detached world_path, "#{BIN}/pot world.stdin world.stdout world.stdout #{pid_file} java -Xmx1024M -Xms512M -jar server.jar nogui"
  
  file_wait_timer = EM.add_periodic_timer(0.1) do
    if File.exist? pid_file
      file_wait_timer.cancel
      puts "pot started:#{pid_file}"
      
      watch_world pid_file
    end
  end
end

def world_running? world_id
  pid_file = "#{PID_PATH}/#{world_id}"
  if File.exists? pid_file
    pid = File.read(pid_file).strip.to_i
    Process.alive? pid
  end
end

def watch_world pid_file
  pid = read_pid_file pid_file
  world_id = File.basename pid_file
  EM.watch_process pid, WorldProcessWatcher, world_id, "#{WORLDS}/#{world_id}/world.stdout"
end

def read_pid_file pid_file
  File.exists?(pid_file) && File.read(pid_file).strip.to_i
end

PID_PATH = "#{ROOT}/tmp/minecraft-server-pids"

EM.kqueue = true if EM.kqueue?

EM.run do
  Dir["#{PID_PATH}/*"].each do |pid_file|
    pid = read_pid_file(pid_file)
    if Process.alive? pid
      puts "Found running world:#{pid_file}"
      watch_world pid_file
    else
      puts "Found dead world:#{pid_file}"
      FileUtils.rm_f pid_file
    end
  end
  
  # spawn_world "4e7be5c82013df44e7000002"
end

