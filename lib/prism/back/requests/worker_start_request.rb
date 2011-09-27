module Prism
  class WorkerStartRequest < BusyOperationRequest
    process "workers:requests:start", :instance_id

    def busy_hash
      ["workers:busy", instance_id, state:'starting']
    end
    
    def perform_operation
      info "starting stopped worker:#{instance_id}"
      worker = Worker.find instance_id
      raise "expected worker:#{instance_id} to be :stopped" unless worker.server.state == 'stopped'
      
      worker.start!
    end
    
    def operation_succeeded worker
      info "started stopped worker:#{instance_id}"

      set = Prism.redis.store_running_worker instance_id, worker.public_ip_address, Time.now.utc
      set.callback {
        Prism.redis.publish "workers:requests:start:#{instance_id}", worker.public_ip_address
      }
    end
    
    def operation_failed
      error "failed to start worker:#{instance_id}"      
    end
  end
end