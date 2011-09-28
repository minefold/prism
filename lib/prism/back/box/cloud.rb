module Prism
  module Box
    class Cloud < Base
      def self.compute_cloud
        Fold.compute_cloud
      end
      
      def self.tags
        {"Name" => "worker"}.merge(Fold.worker_tags || {})
      end
      
      def self.all *c, &b
        handler = EM::Callback(*c, &b)
        EM.defer( proc { 
            compute_cloud.servers.select {|s| tags.all? {|k,v| s.tags[k.to_s] == v.to_s} }.map {|s| Cloud.new s }
          }, proc{ |cloud_boxes| 
            handler.call cloud_boxes 
          })
      end
      
      def self.create options = {}
        @deferrable = EM::DefaultDeferrable.newc
        
        EM.defer( proc {
            begin
              options = {
                :private_key_path => SSH_PRIVATE_KEY_PATH,
                :username => 'ubuntu',
                :image_id => 'ami-6f864706',
                :groups => %W{default proxy},
                :flavor_id => 'm1.large'
              }.merge(options)

              cloud_box = Cloud.new compute_cloud.servers.bootstrap(options)
              compute_cloud.create_tags cloud_box.instance_id, tags
              cloud_box
            rescue => e
              puts "ERROR: create cloud box failed  #{e}"
              nil
            end
          }, proc{ |cloud_box| 
            if cloud_box
              op = cloud_box.prepare_for_minefold
              op.callback { @deferrable.succeed cloud_box }
              op.errback  { @deferrable.fail }
            else
              @deferrable.fail
            end
          })
          
        @deferrable
      end
      
      attr_reader :vm
        
      def initialize vm
        @vm = vm
        vm.private_key_path = SSH_PRIVATE_KEY_PATH
        
        @instance_id, @host = vm.instance_id, vm.public_ip_address
        @started_at = Time.now
      end
      
      def query_state *c,&b
        cb = EM::Callback(*c,&b)
        EM.defer(proc { vm.state }, proc { |state| cb.call state })
      end
      
      def kill_process_command matcher
        "sudo kill -9 $(ps -eF | grep '#{matcher}' | awk '{print $2}') &> /dev/null"
      end

      def prepare_for_minefold
        @deferrable = EM::DefaultDeferrable.new
        EM.defer(proc {
          puts "preparing box:#{instance_id} for minefold"

          write_out_env_vars = "echo #{Fold.env} > ~/FOLD_ENV && echo #{Fold.worker_user} > ~/FOLD_WORKER_USER"
          clone_repo = "cd ~ && sudo rm -rf minefold && sudo rm -rf ~/.bundler && GIT_SSH=~/deploy-ssh-wrapper git clone -q --depth 1 -b #{Fold.worker_git_branch} #{WORKER_GIT_REPO} minefold"
          bundle_install = "cd ~/minefold && bundle install --path ~/bundle --deployment --quiet --binstubs --without proxy:development:test"
          start_widget = "FOLD_ENV=#{Fold.env} upstart start widget"

          commands = [
            [ kill_process_command('[r]esque'),
              kill_process_command('[j]ava'),
              kill_process_command('[r]ava'),
              write_out_env_vars
              ].join(";"),
            "#{clone_repo} && #{bundle_install}",
            "#{start_widget}"
          ]

          commands.each do |cmd|
            log cmd
            results = server.ssh cmd
            log results
          end
        }, proc {
          puts "Waiting for worker to respond"
          n = 0
          @timer = EM.add_periodic_timer(1) do
            op = query_worlds
            op.callback { @timer.cancel; @deferrable.succeed }

            if (n+=1) > 20
              @deferrable.fail
              timer.cancel
            end
          end
        })
        @deferrable
      end
    end
  end
end