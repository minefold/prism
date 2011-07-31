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
        :image_id => 'ami-87a462ee',
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
    
    def kill_process_command matcher
      "sudo kill $(ps -eF | grep '#{matcher}' | awk '{print $2}')"
    end

    def prepare_for_minefold
      puts "Preparing worker:#{instance_id} for minefold"
      god = "cd ~/minefold && sudo bin/god"
      
      ensure_god_isnt_running = kill_process_command('[g]od -c')
      ensure_thin_isnt_running = kill_process_command('[t]hin')
      write_out_env_vars = "echo #{Fold.env} > ~/FOLD_ENV && echo #{Fold.worker_user} > ~/FOLD_WORKER_USER"
      clone_repo = "cd ~ && sudo rm -rf minefold && GIT_SSH=~/deploy-ssh-wrapper git clone -q --depth 1 -b #{Fold.worker_git_branch} #{WORKER_GIT_REPO}"
      bundle_install = "cd ~/minefold && bundle install --quiet --binstubs --without proxy development test cli"
      start_worker_app = "#{god} -c ~/minefold/worker/config/worker.god && #{god} start worker-app"
      
      commands = [
        "#{ensure_god_isnt_running}; #{ensure_thin_isnt_running}; #{write_out_env_vars}",
        "#{clone_repo} && #{bundle_install}; #{ensure_god_isnt_running}; #{ensure_thin_isnt_running}",
        "#{start_worker_app}"
      ]
    
      commands.each do |cmd|
        log cmd
        results = server.ssh cmd
        log results #if results.any? {|r| r.status != 0 }
      end
    
      wait_for_worker_ready
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

  end
  
end
