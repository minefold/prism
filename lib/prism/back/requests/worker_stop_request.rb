module Prism
  class WorkerStopRequest < DeferredOperationRequest
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

      set = Prism.redis.store_running_worker instance_id, worker.public_ip_address, Time.now.utc
      set.callback {
        Prism.redis.publish "workers:requests:stop:#{instance_id}", worker.public_ip_address
      }
    end
    
    def operation_failed
      error "failed to stop worker:#{instance_id}"      
    end
  end
end