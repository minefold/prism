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
      select {|s| s.tags["Name"] != "worker" && s.tags["environment"] == "production" }.
      map{|s| Worker.new s }
  end

  def self.running
    existing.select {|w| w.server.state == 'running' }
  end
  
  def self.stopped
    existing.select {|w| w.server.state == 'stopped' }
  end

  def self.create options = {}
    options = {
      :private_key_path => SSH_PRIVATE_KEY_PATH,
      :username => 'ubuntu',
      :image_id => 'ami-afea2dc6',
      :groups => %W{default proxy},
      :flavor_id => 'm1.large'
    }.merge(options)
    
    worker = Worker.new compute_cloud.servers.bootstrap(options)
    
    compute_cloud.create_tags worker.instance_id, "Name" => "worker", "environment" => "production"
    
    worker.prepare_for_minefold
    worker
  end
  
  def self.get instance_id
    Worker.new compute_cloud.servers.get(instance_id)
  end
  
end