module Prism
  class BusyOperationRequest < Request
    def run
      op = redis.hset_hash *busy_hash
      op.callback do 
        deferred_operation do
          redis.hdel *busy_hash[0..1]
        end
      end
    end
      
    def deferred_operation &blk
      start_time = Time.now
      
      deferrable = perform_operation
      deferrable.callback do |result|
        operation_succeeded result
        StatsD.increment_and_measure_from start_time, "#{statsd_key}.successful"
        yield
      end
      
      deferrable.errback do |error|
        error "operation failed", e
        operation_failed
        StatsD.increment_and_measure_from start_time, "#{statsd_key}.failed"
        yield
      end
    end
  end
end