module Prism
  class WorkerCreateRequest < Request

    process "workers:requests:create", :request_id
    
    def run
      instance_type = 'm1.large'
      
      info "creating new worker type:#{instance_type}"
      EM.defer(proc { 
        begin
          Worker.create flavor_id:instance_type
        rescue => e
          error "create worker", e
        end
      }, proc { |worker| 
        if worker
          redis_connect do |redis|
            info "worker:#{worker.instance_id} created"
            set = redis.store_running_worker worker.instance_id, worker.public_ip_address, Time.now.utc
            set.callback {
              debug "publish workers:requests:create:#{request_id}"
              redis.publish "workers:requests:create:#{request_id}", {instance_id:worker.instance_id, host:worker.public_ip_address}.to_json
            }
          end
        else
          error "failed to create worker"
        end
      })
    end
    
  end
end