module Prism
  class WorkerStopRequest < BusyOperationRequest
    process "workers:requests:stop", :instance_id

    def busy_hash
      ["workers:busy", instance_id, state:'stopping']
    end
    
    def perform_operation
      info "stopping box:#{instance_id}"
      
      df = EM::DefaultDeferrable.new
      
      Box.find instance_id do |box|
        if box
          df.succeed box
        else
          error "failed to find box:#{instance_id}"
          df.fail
        end
      end
      
      df
    end
    
    def operation_succeeded box
      info "stopped box:#{instance_id}"

      op = redis.hdel "workers:running", instance_id
      op.callback {
        redis.publish "workers:requests:stop:#{instance_id}", box.host
      }
    end
    
    def operation_failed
      error "failed to stop box:#{instance_id}"      
    end
  end
end