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
        :image_id => 'ami-6f864706',
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
      "sudo kill -9 $(ps -eF | grep '#{matcher}' | awk '{print $2}') &> /dev/null"
    end

    def prepare_for_minefold
      puts "Preparing worker:#{instance_id} for minefold"
      god = "cd ~/minefold && sudo bin/god"
      
      write_out_env_vars = "echo #{Fold.env} > ~/FOLD_ENV && echo #{Fold.worker_user} > ~/FOLD_WORKER_USER"
      clone_repo = "cd ~ && sudo rm -rf minefold && sudo rm -rf ~/.bundler && GIT_SSH=~/deploy-ssh-wrapper git clone -q --depth 1 -b #{Fold.worker_git_branch} #{WORKER_GIT_REPO}"
      bundle_install = "cd ~/minefold && bundle install --path ~/bundle --deployment --quiet --binstubs --without proxy:development:test"
      start_worker_app = "#{god} -c ~/minefold/worker/config/worker.god && #{god} start worker-app"
      
      commands = [
        [kill_process_command('[g]od -c'), 
          kill_process_command('[t]hin'),
          kill_process_command('[r]esque'),
          kill_process_command('[t]ail'),
          kill_process_command('[l]ogger -t'),
          kill_process_command('[j]ava'),
          write_out_env_vars
          ].join(";"),
        "#{clone_repo} && #{bundle_install}",
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
