require 'net/ssh'


module Worker
  class Cloud < Base
    def self.compute_cloud
      Fold.compute_cloud
    end
    
    def self.all
      compute_cloud.servers.
                select {|s| tags.all? {|k,v| s.tags[k.to_s] == v.to_s} }.
                   map {|s| Cloud.new s }
    end
    
    def self.tags
      {"Name" => "worker"}.merge(Fold.worker_tags || {})
    end

    def self.create options = {}
      options = {
        :private_key_path => SSH_PRIVATE_KEY_PATH,
        :username => 'ubuntu',
        :image_id => 'ami-afea2dc6',
        :groups => %W{default proxy},
        :flavor_id => 'm1.large'
      }.merge(options)

      worker = Cloud.new compute_cloud.servers.bootstrap(options)
      compute_cloud.create_tags worker.instance_id, tags

      worker.prepare_for_minefold
      worker
    end

    def self.find instance_id
      Cloud.new compute_cloud.servers.get(instance_id)
    end
    
    include HTTParty
    attr_reader :server
    
    def initialize server
      @server = server
      server.private_key_path = SSH_PRIVATE_KEY_PATH
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
        server_info = JSON.parse get("/worlds", timeout:20).body
        Worlds.new self, server_info.map {|h| World.new self, h["id"], h["port"]}
      rescue => e
        puts e.inspect
        []
      end
    end

    def world world_id
      begin
        server_info = JSON.parse get("/worlds/#{world_id}").body
        World.new self, server_info["id"], server_info["port"]
      rescue => e
        puts "#{e.inspect}\n#{e.backtrace}"
        nil
      end
    end

    def responding?
      get("/", timeout:10).body rescue false
    end
    
    def url
      "http://#{public_ip_address}:3000"
    end

    def start_world world_id, min_heap_size, max_heap_size
      response = get("/worlds/create?id=#{world_id}&min_heap_size=#{min_heap_size}&max_heap_size=#{max_heap_size}", timeout:4 * 60)
      puts response.body unless response.code == "200"
   
      world world_id
    end

    def stop_world world_id
      get "/worlds/#{world_id}/destroy"
    end

    def prepare_for_minefold
      puts "Preparing worker:#{instance_id} for minefold"
      commands = [
        "echo #{Fold.env} > ~/minefold/FOLD_ENV && echo #{Fold.worker_user} > ~/minefold/FOLD_WORKER_USER",
        "cd ~/minefold && GIT_SSH=~/deploy-ssh-wrapper git fetch && git checkout #{Fold.worker_git_branch} && GIT_SSH=~/deploy-ssh-wrapper git pull origin #{Fold.worker_git_branch}",
        "cd ~/minefold && bundle install --without proxy development test cli",
        "sudo god status && sudo god stop worker-app && sudo god quit", # quit god if its running
        "sudo god -c ~/minefold/worker/config/worker.god"
      ]
    
      commands.each do |cmd|
        log cmd
        results = server.ssh cmd
        log results #if results.any? {|r| r.status != 0 }
      end
    
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

    def wait_for_ssh options={}
      puts "Waiting for ssh access"
      timeout = options[:timeout] || 180
    
      # we need to wait for the server to do all its bootup stuff
      Timeout::timeout(timeout) do
        begin
          Timeout::timeout(8) do 
            puts "checking ssh..."
            server.ssh "pwd"
          end
        rescue Errno::ECONNREFUSED, Net::SSH::AuthenticationFailed, Timeout::Error => e
          sleep 5
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

    def log message
      puts "[#{instance_id}] #{message}"
    end
  end
  
end
