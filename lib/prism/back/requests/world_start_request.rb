module Prism
  class WorldStartRequest < DeferredOperationRequest
    process "worlds:requests:start", :instance_id, :world_id, :min_heap_size, :max_heap_size
    
    def busy_hash
      ["worlds:busy", world_id, instance_id:instance_id, state:'starting']
    end
    
    def perform_operation
      info "starting world:#{world_id} on worker:#{instance_id}"
      @worker = Worker.find instance_id
      @worker.start_world world_id, min_heap_size, max_heap_size
    end
    
    def operation_succeeded world
      info "world:#{world_id} started on worker:#{instance_id}"
    
      op = redis.store_running_world instance_id, world_id, @worker.public_ip_address, world.port
      op.callback {
        debug "publishing worlds:requests:start:#{world_id}"
        redis.publish "worlds:requests:start:#{world_id}", { host:@worker.public_ip_address, port:world.port }.to_json
      }
    end
    
    def operation_failed
      error "failed to start world:#{world_id} on worker:#{instance_id}"
    end
  end
end