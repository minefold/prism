module Prism
  module Sweeper 
    include Debugger
    
    def perform_sweep
      deferred = EM::DefaultDeferrable.new
      
      redis = Prism.redis
      redis.hgetall_json 'workers:running' do |running_workers|
        redis.hgetall_json 'workers:busy' do |busy_workers|
          redis.hgetall_json 'worlds:running' do |running_worlds|
            redis.hgetall_json 'worlds:busy' do |busy_worlds|
              EM.defer(proc { 
                  update_state_sync running_workers, busy_workers, running_worlds, busy_worlds
                }, proc { deferred.succeed })
            end
          end
        end
      end
      
      deferred
    end

    def update_state_sync redis_workers, redis_busy_workers, redis_worlds, redis_busy_worlds
      redis = Prism.redis
      
      running_workers, responding_workers, broken_workers, running_worlds = [], [], [], {}

      Worker.all.each do |worker|
        if worker.running?
          running_workers << worker
          if worker.responding?
            worlds = worker.worlds
            responding_workers << worker
            running_worlds.merge! worlds.each_with_object({}) {|world, hash| hash[world.id] = world }
          else
            broken_workers << worker
          end
        end
      end
            
      lost_worker_ids = redis_workers.keys - running_workers.map(&:instance_id)
      lost_worker_ids.each do |instance_id|
        debug "lost worker:#{instance_id}"
        redis.hdel "workers:running", instance_id
      end
      
      lost_busy_worker_ids = redis_busy_workers.keys - running_workers.map(&:instance_id)
      lost_busy_worker_ids.each do |instance_id|
        debug "lost busy worker:#{instance_id}"
        redis.hdel "workers:busy", instance_id
      end
      
      new_workers = running_workers.reject{|w| redis_workers.keys.include? w.instance_id }
      new_workers.each do |worker|
        debug "found worker:#{worker.instance_id}"
        redis.hset_hash "workers:running", worker.instance_id, instance_id:worker.instance_id, host:worker.public_ip_address, started_at:worker.started_at
      end
      
      lost_world_ids = redis_worlds.keys - running_worlds.keys
      lost_world_ids.each do |world_id|
        debug "lost world:#{world_id}"
        redis.hdel "worlds:running", world_id
      end
      
      lost_busy_world_ids = redis_busy_worlds.keys - running_worlds.keys
      lost_busy_world_ids.each do |world_id|
        debug "lost busy world:#{world_id}"
        redis.hdel "worlds:busy", world_id
      end
      
      new_worlds = running_worlds.reject{|world_id, world| redis_worlds.keys.include? world_id }
      new_worlds.each do |world_id, world|
        debug "found world:#{world_id}"
        redis.hset_hash "worlds:running", world.id, instance_id:world.worker.instance_id, host:world.worker.public_ip_address, port:world.port
      end
      
      broken_workers.each do |worker|
        debug "fixing broken worker:#{worker.instance_id}"
        redis.lpush "workers:requests:fix", worker.instance_id
      end

      running_workers.each do |worker|
        uptime_minutes = ((Time.now - worker.started_at) / 60).to_i
        close_to_end_of_hour = uptime_minutes % 60 > 55
  
        world_count = running_worlds.count{|world_id, w| w.worker.instance_id == worker.instance_id }
      
        worker_not_busy = redis_busy_workers.count {|busy_worker_id, world| busy_worker_id == worker.instance_id } == 0
       
        world_not_busy = redis_busy_worlds.count {|busy_world_id, data| data['instance_id'] == worker.instance_id } == 0
  
        if close_to_end_of_hour and world_count == 0 and worker_not_busy and world_not_busy
          puts "worker:#{worker.instance_id} terminating idle"
          redis.lpush "workers:requests:stop", worker.instance_id
        end
      end
    end
    
  end
end