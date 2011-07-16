require 'net/ssh'

class Worker
  attr_reader :server
  
  def initialize server
    @server = server
    server.private_key_path = SSH_PRIVATE_KEY_PATH
  end
  
  def instance_id
    server.id
  end
  
  def public_ip_address
    server.public_ip_address
  end
  
  def url
    "http://#{public_ip_address}:3000"
  end
  
  def start!
    if server.state == 'stopped'
      server.start
      server.wait_for { ready? }
      wait_for_ssh
      bootstrap
    end
  end
  
  def stop!
    server.stop
  end
  
  def worlds
    return [] unless public_ip_address
    
    begin
      server_info = JSON.parse http_get("/")
      Worlds.new self, server_info.map {|h| World.new self, h["id"], h["port"]}
    rescue => e
      puts e.inspect
      []
    end
  end
  
  def uptime
    if server.state == 'running'
      result = server.ssh("uptime").first.stdout.split(/up |,/)[1]  # These are backticks,upper left key on my keyboard
      hours, minutes = result.split(':').map{|r| r.to_i }
      hours * 60 * 60 + minutes * 60
    end
  end
  
  def start_world world_id
    http_get "/worlds/create?id=#{world_id}"

    server_info = JSON.parse http_get("/worlds/#{world_id}")
    World.new self, server_info["id"], server_info["port"]
  end
  
  def stop_world world_id
    http_get "/worlds/#{world_id}/destroy"
  end
  
  def bootstrap
    log "Bootstrapping..."

    bootstrap_commands = [
      "cd ~/minefold",
      "GIT_SSH=~/deploy-ssh-wrapper git pull origin master",
      "bundle install --without proxy development test cli",
      "god -c ~/minefold/worker/config/worker.god --no-syslog"
    ]

    results = server.ssh bootstrap_commands.join(" && ")
    log results if results.any? {|r| r.status != 0 }

    log "Waiting for worker to respond"

    Timeout::timeout(20) do
      begin
        `curl -s #{url}`
      end while $?.exitstatus != 0
    end

    log "Server not responding...." if $?.exitstatus != 0
  end
  
  private
  
  def uri
    @uri ||= URI.parse url
  end
  
  def http_get path
    res = Net::HTTP.start(uri.host, uri.port) {|http| http.get path }
    res.body
  end
  
  def wait_for_ssh
    Timeout::timeout(60) do
      begin
        Timeout::timeout(8) do
          server.ssh "pwd"
        end
      rescue Errno::ECONNREFUSED
        sleep(2)
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