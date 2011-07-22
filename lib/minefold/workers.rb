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

  def self.create
    worker = Worker.new compute_cloud.servers.bootstrap(
      :private_key_path => SSH_PRIVATE_KEY_PATH,
      :username => 'ubuntu',
      :image_id => 'ami-4f5b9f26',
      :groups => %W{default proxy},
      :flavor_id => 'm1.large'
    )
    compute_cloud.create_tags worker.instance_id, "Name" => "worker"
    
    worker.prepare_for_minefold
    worker
  end
  
  def self.get instance_id
    Worker.new compute_cloud.servers.get(instance_id)
  end
  
end