namespace :prism do
  desc 'notifies players in game'
  task :message_players do
  end
  
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
        ssh "sudo stop prism; sudo stop sweeper"
        EM.stop
      end
      
      messages = {
        "10 mins until 15 minutes of scheduled maintenance" => 120,
        "8 mins until 15 minutes of scheduled maintenance" => 120,
        "5 mins until 15 minutes of scheduled maintenance" => 180,
        "2 mins until 15 minutes of scheduled maintenance" => 120,
        "1 minute until 15 minutes of scheduled maintenance" => 60,
        "Maintenance in 10 seconds, please wait 15 minutes before reconnecting" => 10
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