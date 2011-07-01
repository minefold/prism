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

  def self.running
    compute_cloud.servers.
      select {|s| s.state == 'running' && s.tags["Name"] != "Proxy" }.
      map{|s| Worker.new s }
  end

  def self.start
    puts "Starting worker"
    server = compute_cloud.servers.bootstrap(
      :private_key_path => '~/.ssh/minefold-dave.pem',
      :username => 'ubuntu',
      :image_id => 'ami-8ca358e5',
      :groups => %W{default proxy},
      :key_name => 'minefold-dave',
      :flavor_id => 'm1.large',
      :tags => {"Name" => "worker"}
    )

    server.wait_for { ready? }

    puts "Bootstrapping"
    bootstrap_commands = [
      "cd ~/minefold",
      "GIT_SSH=~/deploy-ssh-wrapper git pull origin master",
      "bundle",
      "god -c ~/minefold/worker/config/worker.god"
    ]

    server.ssh bootstrap_commands.join(" && ")

    puts "Waiting for worker to respond"
    worker_url = "http://#{server.public_ip_address}:3000"

    Timeout::timeout(20) do
      begin
        `curl -s #{worker_url}`
      end while $?.exitstatus != 0
    end

    puts "#{server.id} started at #{worker_url}"
    puts "Server not responding...." if $?.exitstatus != 0

    Worker.new server
  end
end