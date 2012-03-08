namespace :prism do
  desc 'notifies players about restart, waits, restarts'
  task :graceful do
    require 'prism/back'
    
    raise 'Set EC2_SSH' unless ENV['EC2_SSH']
    raise 'Set HOST' unless ENV['HOST']
    
    def ssh cmd
      ssh_cmd = %Q{ssh -i #{ENV['EC2_SSH']} ubuntu@#{ENV['HOST']} "#{cmd}"}
      puts `#{ssh_cmd}`
    end
    
    EM.run do
      @redis = Prism::PrismRedis.connect
    
      def message_running_worlds message, *a, &b
        cb = EM::Callback *a, &b
        op = @redis.hgetall_json 'worlds:running'
        op.callback do |worlds|
          puts "Messaging #{worlds.count} worlds"
          worlds.each do |world_id, world|
            @redis.publish "workers:#{world['instance_id']}:worlds:#{world_id}:stdin", "say #{message}"
            puts message
          end
          cb.call worlds
        end
        cb
      end
      
      def restart_prism
        puts "restarting prism"
        ssh "sudo stop prism; sudo restart prism_back; sudo restart sweeper; sudo start prism"
        EM.stop
      end
      
      messages = {
        "In 10 mins Minefold will be down for 2 minutes of scheduled maintenance" => 10,
        "In 10 mins you'll be disconnected, please wait 2 minutes before reconnecting" => 5*60,
        "Down for scheduled quick maintenance in 5 minutes" => 2 * 60,
        "Down for scheduled quick maintenance in 3 minutes" => 60,
        "Down for scheduled quick maintenance in 2 minutes" => 60,
        "Down for scheduled quick maintenance in 1 minute"  => 30,
        "Down for scheduled quick maintenance in 30 seconds" => 20,
        "Maintenance in 10 seconds, please wait 2 minutes before reconnecting" => 10
      }
      
      EM::Iterator.new(messages).each(proc{ |(message, delay),iter|
        message_running_worlds message do |worlds|
          if worlds.size == 0
            restart_prism
          else
            EM.add_timer(delay) { iter.next }
          end
        end
      }, proc { restart_prism })
    end
  end
end