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
      puts "waiting for VM ready"
      server.wait_for { ready? }
      wait_for_ssh
      prepare_for_minefold
    end
    self
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
      server_info = JSON.parse get("/", timeout:20).body
      Worlds.new self, server_info.map {|h| World.new self, h["id"], h["port"]}
    rescue => e
      puts e.inspect
      []
    end
  end
  
  def uptime_minutes
    ((Time.now - server.created_at) / 60).floor
  end
  
  def start_world world_id
    get("/worlds/create?id=#{world_id}", timeout:90)

    server_info = JSON.parse get("/worlds/#{world_id}").body
    World.new self, server_info["id"], server_info["port"]
  end
  
  def stop_world world_id
    get "/worlds/#{world_id}/destroy"
  end
  
  def prepare_for_minefold
    puts "Preparing worker:#{instance_id} for minefold"
    commands = [
      "sudo rm -f /home/ubuntu/.god/pids/*",
      "cd ~/minefold",
      "GIT_SSH=~/deploy-ssh-wrapper git pull origin master",
      "bundle install --without proxy development test cli",
      "sudo god -p #{PIDS}",
      "sudo god load ~/minefold/worker/config/worker.god",
      "sudo god start worker-app"
    ]

    results = server.ssh commands.join(" && ")
    log results if results.any? {|r| r.status != 0 }

    log "Waiting for worker to respond"
    Timeout::timeout(20) do
      begin
        get("/", timeout:2).body
      rescue Errno::ECONNREFUSED
        sleep 1
        retry
      rescue Timeout::Error
        retry
      end
    end
    
  end
  
  private
  
  def get path, options={}
    self.class.base_uri url
    self.class.get path, options
  end
  
  def uri
    @uri ||= URI.parse url
  end
  
  def wait_for_ssh
    puts "Waiting for ssh access"
    # we need to wait for the server to do all its bootup stuff
    Timeout::timeout(180) do
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