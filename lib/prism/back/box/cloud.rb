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
        cb = EM::Callback(*c, &b)
        EM.defer( proc { 
            compute_cloud.servers.select {|s| tags.all? {|k,v| s.tags[k.to_s] == v.to_s} }.map {|s| Cloud.new s }
          }, proc{ |cloud_boxes| 
            cb.call cloud_boxes 
          })
        cb
      end
      
      def self.find instance_id, *c, &b
        cb = EM::Callback(*c, &b)
        EM.defer(proc {
            compute_cloud.servers.get(instance_id)
          }, proc { |vm| 
            cb.call Cloud.new(vm) 
          })
        cb
      end
      
      def self.cloud_init_script
        <<-EOS
#!/bin/sh
# set hostname to ec2 instance id
/usr/local/ec2/ec2-hostname.sh

# restart hostname sensitive services
/etc/init.d/collectd restart
restart rsyslog
        EOS
      end
      
      def self.create options = {}
        @deferrable = EM::DefaultDeferrable.new
        
        EM.defer( proc {
            begin
              options = {
                :private_key_path => SSH_PRIVATE_KEY_PATH,
                :username => 'ubuntu',
                :image_id => 'ami-595e9230',
                :groups => %W{default box},
                :flavor_id => 'm1.large',
                :user_data => cloud_init_script
              }.merge(options)

              vm = compute_cloud.servers.bootstrap(options)
              # p vm
              
              cloud_box = Cloud.new vm
              compute_cloud.create_tags cloud_box.instance_id, tags
              cloud_box
            rescue => e
              puts "ERROR: create cloud box failed  #{e}"
              nil
            end
          }, proc{ |cloud_box| 
            if cloud_box
              @deferrable.succeed cloud_box
            else
              @deferrable.fail
            end
          })
          
        @deferrable
      end
      
      attr_reader :vm, :tags
        
      def initialize vm
        @vm = vm
        vm.private_key_path = SSH_PRIVATE_KEY_PATH
        
        @instance_id, @instance_type, @host = vm.id, vm.flavor_id, vm.public_ip_address
        @started_at = vm.created_at
        @tags = vm.tags
      end
      
      def start
        df = EM::DefaultDeferrable.new
        
        cb = EM::Callback(*c, &b)
        EM.defer(proc {
            begin
              vm.start
              server.wait_for { ready? }
              wait_for_ssh
              true
            rescue => e
              puts "start box:#{instance_id} failed: #{e}"
              df.fail e
              false
            end
          }, proc { |succeeded|
            if succeeded
              df.succeed cloud_box
            else
              df.fail
            end
          })
        df
      end
      
      def stop
        df = EM::DefaultDeferrable.new
        
        EM.defer(proc { vm.destroy rescue df.fail }, proc { df.succeed })
        
        df
      end
      
      
      def query_state *c,&b
        cb = EM::Callback(*c,&b)
        EM.defer(proc { vm.state }, proc { |state| cb.call state })
      end
      
      def kill_process_command matcher
        "sudo kill -9 $(ps -eF | grep '#{matcher}' | awk '{print $2}') &> /dev/null"
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
end