module Prism
  class WorkerStartRequest < BusyOperationRequest
    process "workers:requests:start", :instance_id

    def busy_hash
      ["workers:busy", instance_id, state:'starting']
    end
    
    def perform_operation
      info "starting stopped worker:#{instance_id}"

      df = EM::DefaultDeferrable.new
      
      Box.find instance_id do |box|
        box.query_state do |state|
          if worker.server.state == 'stopped'
            op = box.start
            op.callback { df.succeed box }
            op.errback { |e| df.fail e }
          else
            df.fail "expected worker:#{instance_id} to be :stopped" 
          end
        end
      end
      
      df
    end
    
    def operation_succeeded box
      info "started stopped worker:#{instance_id}"

      set = redis.store_running_worker instance_id, worker.public_ip_address, Time.now.utc
      set.callback do
        redis.publish "workers:requests:start:#{instance_id}", worker.public_ip_address
      end
    end
    
    def operation_failed
      error "failed to start worker:#{instance_id}"      
    end
  end
end