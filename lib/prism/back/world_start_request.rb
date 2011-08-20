module Prism
  class WorldStartRequest < Request
    
    message_arguments :instance_id, :world_id, :min_heap_size, :max_heap_size
    
    def run instance_id, world_id, min_heap_size, max_heap_size
      # SUPERVISED_WORLDS[@world_id].worker = worker
      # BUSY_WORKERS[worker.instance_id] = :starting_world

      info "starting world #{instance_id} > #{world_id}"
      EM.defer(proc { 
          begin
            @worker = Worker.find instance_id
            @worker.start_world world_id, min_heap_size, max_heap_size
          rescue => e
            error "start world", e
          end
        }, proc {|world|
          if world
            info "world started"
            
            redis_connect do |redis|
              debug "storing world"
              op = redis.store_running_world instance_id, world_id, @worker.public_ip_address, world.port
              op.callback {
                debug "publishing worlds:requests:start:#{world_id}"
                redis.publish "worlds:requests:start:#{world_id}", { host:@worker.public_ip_address, port:world.port }.to_json
              }
            end
          else
            error "world didn't start"
            # couldn't start world, mark worker as bad
            # SUPERVISED_WORLDS.delete @world_id
            # BUSY_WORKERS[worker.instance_id] = :not_responding
          end
      })
    end
    
  end
end