module Prism
  class WorkerStartRequest < Request
    process "workers:requests:start", :instance_id
    
    def run 
      # BUSY_WORKERS[worker.instance_id] = :starting

      EM.defer(proc { 
          begin
            worker = Worker.find instance_id
            raise "expected worker:#{instance_id} to be :stopped" unless worker.server.state == 'stopped'
            
            worker.start!
          rescue => e
            error "worker start", e
          end 
        }, proc { |worker|
          redis_connect do |redis|
            if worker
              info "started stopped worker #{instance_id}"

              set = redis.store_running_worker instance_id, worker.public_ip_address, Time.now.utc
              set.callback {
                redis.publish "workers:requests:start:#{instance_id}", worker.public_ip_address
              }
            else
              error "failed to start worker:#{instance_id}"
              # worker start failed, never started the world so forget about it
              # SUPERVISED_WORLDS.delete @world_id
              # BUSY_WORKERS[instance_id] = :not_responding
              # EM.next_tick { get_world_running }
            end
          end
      })      
    end
    
  end
end