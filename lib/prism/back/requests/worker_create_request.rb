module Prism
  class WorkerCreateRequest < BusyOperationRequest
    
    process "workers:requests:create", :request_id, :instance_type
    
    def busy_hash
      ["workers:busy", request_id, state:'creating']
    end
    
    def perform_operation
      info "creating new worker type:#{instance_type} req:#{request_id}"
      Box.create flavor_id:instance_type
    end
    
    def operation_succeeded worker
      info "worker:#{worker.instance_id} created"
      op = redis.hset_hash "workers:running", worker.instance_id, instance_id:worker.instance_id, host:worker.host, started_at:Time.now.utc, instance_type:instance_type
      op.callback {
        debug "publish workers:requests:create:#{request_id}"
        redis.publish_json "workers:requests:create:#{request_id}", instance_id:worker.instance_id, host:worker.host
      }
    end
    
    def operation_failed
      error "failed to create worker type:#{instance_type} req:#{request_id}"
    end
    
   
  end
end