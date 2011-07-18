require 'net/ssh'

class Worker
  include HTTParty
  
  attr_reader :server
  
  def initialize server
    @server = server
    server.private_key_path = SSH_PRIVATE_KEY_PATH
  end
  
  def url
    "http://#{public_ip_address}:3000"
  end
  
  def instance_id
    server.id
  end
  
  def public_ip_address
    server.public_ip_address
  end
  
  def start!
    if server.state == 'stopped'
      server.start
      server.wait_for { ready? }
      wait_for_ssh
      prepare_for_minefold
    end
  end
  
  def stop!
    server.stop
  end

  def terminate!
    server.destroy
  end
  
  def worlds
    return [] unless public_ip_address
    
    begin
      server_info = JSON.parse get("/", timeout:60).body
      Worlds.new self, server_info.map {|h| World.new self, h["id"], h["port"]}
    rescue => e
      puts e.inspect
      []
    end
  end
  
  def uptime_minutes!
    @uptime_minutes = begin
      if server.state == 'running'
        uptime_message = server.ssh("uptime").first.stdout
        result = uptime_message.split(/up |,/)[1]  # These are backticks,upper left key on my keyboard
        # puts uptime_message
        # puts result
        hours, minutes = 0, 0
        if result =~ /(\d+) min/
          minutes = $1.to_i
        else
          hours, minutes = result.split(':').map{|r| r.to_i }
        end
        hours * 60 + minutes
      end
    end
  end
  
  def uptime_minutes
    @uptime_minutes ||= uptime_minutes!
  end
  
  def start_world world_id
    get("/worlds/create?id=#{world_id}", timeout:3 * 60)

    server_info = JSON.parse get("/worlds/#{world_id}").body
    World.new self, server_info["id"], server_info["port"]
  end
  
  def stop_world world_id
    get "/worlds/#{world_id}/destroy"
  end
  
  def prepare_for_minefold
    puts "Preparing worker for minefold"
    commands = [
      "sudo rm -f /home/ubuntu/.god/pids/*",
      "cd ~/minefold",
      "GIT_SSH=~/deploy-ssh-wrapper git pull origin master",
      "bundle install --without proxy development test cli",
      "sudo god -c ~/minefold/worker/config/worker.god",
    ]

    results = server.ssh commands.join(" && ")
    log results if results.any? {|r| r.status != 0 }

    log "Waiting for worker to respond"
    Timeout::timeout(20) do
      begin
        get("", timeout:2).body
      rescue Errno::ECONNREFUSED
        sleep 1
        retry
      rescue Timeout::Error
        retry
      end
    end
    
  end
  
  private
  
  def get url, options={}
    self.class.base_uri url
    self.class.get url, options
  end
  
  def uri
    @uri ||= URI.parse url
  end
  
  def wait_for_ssh
    puts "Waiting for ssh access"
    Timeout::timeout(60) do
      begin
        Timeout::timeout(8) do
          server.ssh "pwd"
        end
      rescue Errno::ECONNREFUSED
        sleep 2
        retry
      rescue Net::SSH::AuthenticationFailed, Timeout::Error
        retry
      end
    end
  end
  
  def log message
    puts "[#{instance_id}] #{message}"
  end
  
end