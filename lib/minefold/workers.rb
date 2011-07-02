require 'net/http'
require 'json'
require 'timeout'

class Workers
  def self.compute_cloud
    @compute_cloud ||= Fog::Compute.new({
      :provider                 => 'AWS',
      :aws_secret_access_key    => EC2_SECRET_KEY,
      :aws_access_key_id        => EC2_ACCESS_KEY
    })
  end
  
  def self.existing
    compute_cloud.servers.
      select {|s| s.tags["Name"] != "Proxy" }.
      map{|s| Worker.new s }
  end

  def self.running
    existing.select {|w| w.server.state == 'running' }
  end
  
  def self.stopped
    existing.select {|w| w.server.state == 'stopped' }
  end

  def self.start
    if server = stopped.first
      server = server.server
      puts "Starting existing worker..."

      server.start
      server.wait_for { ready? }
      server.private_key_path = '~/.ssh/minefold-dave.pem'
    else
      puts "Starting new worker..."
      server = compute_cloud.servers.bootstrap(
        :private_key_path => '~/.ssh/minefold-dave.pem',
        :username => 'ubuntu',
        :image_id => 'ami-8ca358e5',
        :groups => %W{default proxy},
        :key_name => 'minefold-dave',
        :flavor_id => 'm1.large',
        :tags => {"Name" => "worker"}
      )
    end
      
    worker_url = "http://#{server.public_ip_address}:3000"
    puts "#{server.id} started at #{worker_url}"
    puts "Bootstrapping..."
    bootstrap_commands = [
      "cd ~/minefold",
      "GIT_SSH=~/deploy-ssh-wrapper git pull origin master",
      "bundle install --without proxy development",
      "god -c ~/minefold/worker/config/worker.god"
    ]

    server.ssh bootstrap_commands

    puts "Waiting for worker to respond"

    Timeout::timeout(20) do
      begin
        `curl -s #{worker_url}`
      end while $?.exitstatus != 0
    end

    puts "Server not responding...." if $?.exitstatus != 0

    Worker.new server
  end
end