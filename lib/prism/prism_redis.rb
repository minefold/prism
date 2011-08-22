module Prism
  module Redis
    extend Debugger
    
    def redis_connect &blk
      PrismRedis.new &blk
    end
  end
  
  class PrismRedis
    include Debugger
    
    attr_reader :redis
    def initialize &blk
      @redis = EM::Hiredis.connect
      @redis.errback {|e| error "failed to connect to redis: #{e}" }
      @redis.callback { blk.call(self) }
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
    
    def rpc channel, request_key, data = nil, &blk
      data ||= request_key
      
      lpush channel, data
      
      return unless block_given?
      
      PrismRedis.new do |subscriber|
        debug "subscribing #{channel}:#{request_key}"
        subscriber.subscribe "#{channel}:#{request_key}"
        subscriber.on :message do |channel, response|
          debug "response > #{channel} #{response}"
          subscriber.unsubscribe channel
          yield response
        end
      end
    end

    def rpc_json channel, request_key, request_data = nil, &blk
      rpc(channel, request_key, request_data) {|response| yield JSON.parse(response) }
    end
    
    def method_missing sym, *args, &blk
      redis.send sym, *args, &blk
    end
    
    def handle_error e
      error "REDIS ERROR: #{e}"
    end
  end
end