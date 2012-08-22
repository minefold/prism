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
            # TODO set timeout
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

      def self.widget_branch
        Fold.env == :staging ? 'dev' : 'master'
      end

      def self.log_server
        Fold.env == :staging ? 'logs.fold.to' : 'logs.minefold.com'
      end

      def self.cloud_init_script
        <<-EOS
#!/bin/bash

DOMAIN=minefold.com
HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
IPV4=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Set the host name
hostname $HOSTNAME
echo $HOSTNAME > /etc/hostname

# Add fqdn to hosts file
cat<<EOF > /etc/hosts
# This file is automatically generated by ec2-hostname script
127.0.0.1 localhost
$IPV4 $HOSTNAME.$DOMAIN $HOSTNAME

# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
ff02::3 ip6-allhosts
EOF

# restart hostname sensitive services
/etc/init.d/collectd restart
restart rsyslog

sync
echo 3 > /proc/sys/vm/drop_caches

cat<<EOF > /tmp/attributes.json
{
  "widget": { "branch": "#{widget_branch}"},
  "relp": { "server": "#{log_server}" },
  
  "run_list":[
    "recipe[rsyslog]",
    "recipe[relp::client]",
    "recipe[widget::deploy]"
  ]
}
EOF

chef-solo -c /home/ubuntu/chef/ec2/solo.rb -j /tmp/attributes.json
        EOS
      end

      def self.create options = {}
        @deferrable = EM::DefaultDeferrable.new

        EM.defer( proc {
            begin
              options = {
                :private_key_path => SSH_PRIVATE_KEY_PATH,
                :username => 'ubuntu',
                :groups => %W{default box},
                :flavor_id => 'm1.large',
                :user_data => cloud_init_script,
                :tags => tags,
                :block_device_mapping => [
                  {'DeviceName' => '/dev/sdb', 'VirtualName' => 'ephemeral0'},
                  {'DeviceName' => '/dev/sdc', 'VirtualName' => 'ephemeral1'},
                  {'DeviceName' => '/dev/sdd', 'VirtualName' => 'ephemeral2'},
                  {'DeviceName' => '/dev/sde', 'VirtualName' => 'ephemeral3'}
                ]
              }.merge(options)

              vm = compute_cloud.servers.bootstrap(options)

              Cloud.new vm
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


      def query_state timeout = 20, *c,&b
        @timeout = EM.add_periodic_timer(timeout) do
          puts "timeout querying box"
          cb.call nil
        end
        cb = EM::Callback(*c,&b)
        EM.defer(proc { vm.state }, proc { |state|
          @timeout.cancel
          cb.call state
        })
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