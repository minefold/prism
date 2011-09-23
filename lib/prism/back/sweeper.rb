module Prism
  module Sweeper 
    extend Debugger
    
    def perform_sweep
      deferred = EM::DefaultDeferrable.new
      
      EM.defer(proc { 
          update_state_sync
          shutdown_idle_workers
        }, proc { deferred.succeed })
      deferred
    end

    def update_state_sync
      redis = Prism.redis
      Worker.all.each do |worker|
        if worker.running?
          if worker.responding?
            puts "worker:#{worker.instance_id} uptime_minutes:#{worker.uptime_minutes} worlds:#{worker.worlds.size}"
            redis.store_running_worker worker.instance_id, worker.public_ip_address, worker.started_at
            worlds = worker.worlds
            worlds.each do |world|
              puts "  #{world.id} > #{worker.public_ip_address}:#{world.port}"

              redis.store_running_world worker.instance_id, world.id, worker.public_ip_address, world.port
            end
          else
            puts "worker:#{worker.instance_id} uptime_minutes:#{worker.uptime_minutes} <not responding>"
            
          end
        end
      end
    end
    
    def json_array_to_hash json_array
      Hash[*json_array].each_with_object({}) {|(k,v), hash| hash[k] = JSON.parse v }
    end
    
    def shutdown_idle_workers
      op = Prism.redis.hgetall "workers:running"
      op.callback do |worker_data|
        workers = json_array_to_hash worker_data
        
        op = Prism.redis.hgetall "worlds:running"
        op.callback do |world_data|
          worlds = json_array_to_hash world_data
          
          op = Prism.redis.hgetall "workers:busy"
          op.callback do |busy_worker_data|
            busy_workers = json_array_to_hash busy_worker_data
            
            op = Prism.redis.hgetall "worlds:busy"
            op.callback do |busy_world_data|
              busy_worlds = json_array_to_hash busy_world_data
              
              
              workers.each do |instance_id, worker|
                started_at = Time.parse worker['started_at']
                uptime_minutes = ((Time.now - started_at) / 60).to_i
                close_to_end_of_hour = uptime_minutes % 60 > 55
            
                worker_worlds = worlds.select {|world_id, world| world['instance_id'] == instance_id }
                
                worker_not_busy = busy_workers.count {|busy_worker_id, data| busy_worker_id == instance_id } == 0
                 
                world_not_busy = busy_worlds.count {|busy_world_id, data| data['instance_id'] == instance_id } == 0
            
                if close_to_end_of_hour and worker_worlds.size == 0 and worker_not_busy and world_not_busy and
                  puts "worker:#{instance_id} terminating idle"
                  Prism.redis.lpush "workers:requests:stop", instance_id
                end
              end
            end
          end
        end
      end
    end
    
  end
end