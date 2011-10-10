module Prism
  class WorkerCreateRequest < BusyOperationRequest
    
    process "workers:requests:create", :request_id, :instance_type
    
    def busy_hash
      ["workers:busy", request_id, state:'creating']
    end
    
    def perform_operation
      info "creating new box type:#{instance_type} req:#{request_id}"
      Box.create flavor_id:instance_type
    end
    
    def operation_succeeded box
      info "worker:#{box.instance_id} created"
      redis.store_running_worker box.instance_id, box.host, Time.now.utc, instance_type
      redis.publish_json "workers:requests:create:#{request_id}", instance_id:box.instance_id, host:box.host
    end
    
    def operation_failed
      error "failed to create box type:#{instance_type} req:#{request_id}"
    end
    
   
  end
end