module Prism
  class WorldStopRequest < DeferredOperationRequest
    
    process "worlds:requests:stop", :instance_id, :world_id
    
    def busy_hash
      ["worlds:busy", world_id, instance_id:instance_id, state:'stopping']
    end
    
    def perform_operation
      info "stopping world:#{world_id} on worker:#{instance_id}"
      worker = Worker.find instance_id
      worker.stop_world world_id
    end
    
    def operation_succeeded world
      info "stopped world"
      redis.hdel "worlds:running", world_id
      redis.del "worlds:#{world_id}:connected_players" do
        redis.publish "worlds:requests:stop:#{world_id}"
      end
    end
    
    def operation_failed
      error "failed to stop world:#{world_id} on worker:#{instance_id}"
    end
  end
end