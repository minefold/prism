module Prism
  class WorkerCreateRequest < DeferredOperationRequest
    attr_reader :instance_type
    
    process "workers:requests:create", :request_id
    
    def before_operation
      @instance_type = 'm1.large'
    end
    
    def busy_hash
      ["workers:busy", request_id, state:'creating']
    end
    
    def perform_operation
      info "creating new worker type:#{instance_type} req:#{request_id}"
      Worker.create flavor_id:instance_type
    end
    
    def operation_succeeded worker
      info "worker:#{worker.instance_id} created"
      op = redis.store_running_worker worker.instance_id, worker.public_ip_address, Time.now.utc
      op.callback {
        debug "publish workers:requests:create:#{request_id}"
        redis.publish_json "workers:requests:create:#{request_id}", instance_id:worker.instance_id, host:worker.public_ip_address
      }
    end
    
    def operation_failed
      error "failed to create worker type:#{instance_type} req:#{request_id}"
    end
    
   
  end
end