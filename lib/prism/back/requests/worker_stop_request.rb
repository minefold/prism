module Prism
  class WorkerStopRequest < BusyOperationRequest
    process "workers:requests:stop", :instance_id

    def busy_hash
      ["workers:busy", instance_id, state:'stopping']
    end
    
    def perform_operation
      info "stopping worker:#{instance_id}"
      worker = Worker.find instance_id
      
      worker.stop!
    end
    
    def operation_succeeded worker
      info "stopped worker:#{instance_id}"

      op = redis.hdel "workers:running", instance_id
      op.callback {
        redis.publish "workers:requests:stop:#{instance_id}", worker.public_ip_address
      }
    end
    
    def operation_failed
      error "failed to stop worker:#{instance_id}"      
    end
  end
end