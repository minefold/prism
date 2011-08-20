module Prism
  module Redis
    extend Debugger
    
    def redis_connect &blk
      connection = EM::Hiredis.connect
      connection.callback { yield PrismRedis.new(connection) }
      connection.errback {|e| error "failed to connect to redis: #{e}" }
    end
  end
  
  class PrismRedis
    include Debugger
    
    attr_reader :redis
    def initialize redis
      @redis = redis
      @redis.errback {|e| handle_error e}
    end
    
    def store_running_worker instance_id, host, started_at
      hset_hash "workers:running", instance_id, instance_id:instance_id, host:host, started_at:started_at
    end

    def store_running_world instance_id, world_id, host, port
      hset_hash "worlds:running", world_id, instance_id:instance_id, host:host, port:port
    end
    
    def hset_hash channel, key, value
      op = redis.hset channel, key, value.to_json
      op.errback {|e| handle_error e }
      op
    end
    
    def method_missing sym, *args, &blk
      redis.send sym, *args
    end
    
    def handle_error e
      error "REDIS ERROR: #{e}"
    end
  end
end