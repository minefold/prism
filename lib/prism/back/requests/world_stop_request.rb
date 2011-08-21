module Prism
  class WorldStopRequest < Request
    
    process "worlds:requests:stop", :instance_id, :world_id
    
    def run
      info "stopping world #{instance_id} > #{world_id}"
      EM.defer(proc { 
          begin
            world = worker.stop_world world_id
            info "world stopped"
            world
          rescue => e
            error "stop world", e
          end
        }, proc {
          PrismRedis.new do |redis|
            redis.hdel("worlds:running")
            redis.hdel("worlds:#{world_id}:connected_players")
          end
      })
    end
    
  end
end