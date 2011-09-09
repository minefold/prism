module Prism
  class DeferredOperationRequest < Request
    def run
      op = Prism.redis.hset_hash *busy_hash
      op.callback do 
        deferred_operation do
          Prism.redis.hdel *busy_hash[0..1]
        end
      end
    end
    
    def statsd_key
      "#{self.class.queue.gsub(':', '.')}"
    end
  
    def deferred_operation
      start_time = Time.now
      
      EM.defer(proc { 
          begin
            perform_operation
          rescue => e
            error "operation failed", e
          end
        }, proc { |result|
          if result
            operation_succeeded result
            StatsD.increment_and_measure_from start_time, "#{statsd_key}.successful"
          else
            operation_failed
            StatsD.increment_and_measure_from start_time, "#{statsd_key}.failed"
          end
        
          yield
        })
    end
  end
end