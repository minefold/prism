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
  
    def deferred_operation
      EM.defer(proc { 
          begin
            perform_operation
          rescue => e
            error "operation failed", e
          end
        }, proc { |result|
          if result
            operation_succeeded result
          else
            operation_failed
          end
        
          yield
        })
    end
  end
end