# encoding: UTF-8

module Prism
  class << self
    attr_writer :redis
    def redis
      @redis ||= PrismRedis.connect
    end
    
    attr_writer :redis_factory
    def hiredis_connect
      @redis_factory ? @redis_factory.call : EM::Hiredis.connect(ENV['REDISTOGO_URL'] || REDISTOGO_URL)
    end
  end
  
  class PrismRedis
    include Debugger
    
    attr_reader :redis
    
    def self.connect
      new Prism.hiredis_connect
    end
    
    def initialize connection
      @redis = connection
      @redis.errback {|e| error "failed to connect to redis: #{e}" }
      @redis
    end
    
    def store_running_worker instance_id, host, started_at, instance_type
      hset_hash "workers:running", instance_id, instance_id:instance_id, host:host, started_at:started_at, instance_type:instance_type
    end
    
    def unstore_running_worker instance_id, host
      hdel "workers:running", instance_id
      del "workers:#{instance_id}:worlds"
      publish "workers:requests:stop:#{instance_id}", host
    end

    def store_running_world instance_id, world_id, host, port
      hset_hash "worlds:running", world_id, instance_id:instance_id, host:host, port:port
      sadd "workers:#{instance_id}:worlds", world_id
      hdel "worlds:busy", world_id
      publish_json "worlds:requests:start:#{world_id}", instance_id:instance_id, host:host, port:port
    end
    
    def unstore_running_world instance_id, world_id
      hdel "worlds:running", world_id
      del "worlds:#{world_id}:connected_players", user_id
    end
    
    def hget_json key, field
      op = hget key, field
      op.callback {|data| yield data ? JSON.parse(data) : nil }
      op
    end
    
    def hgetall_json key
      df = EM::DefaultDeferrable.new
      
      op = hgetall key
      op.callback {|data| df.succeed data.each_slice(2).each_with_object({}) {|w, hash| hash[w[0]] = JSON.parse w[1] } }
      op.errback  { df.errback }
      df
    end
    
    def hset_hash channel, key, value
      hset channel, key, value.to_json
    end
    
    def lpush_hash list, value
      lpush list, value.to_json
    end
    
    def publish_json channel, hash
      publish channel, hash.to_json
    end
    
    def method_missing sym, *args, &blk
      redis.send sym, *args, &blk
    end
    
    %w[blpop hexists hget hgetall hset lpush publish scard sadd srem smembers sunion].each do |cmd|
      define_method(:"#{cmd}") do |*args, &blk| 
        op = redis.send cmd, *args
        op.errback {|e| handle_error e }
        op
      end
    end
    
    def handle_error e
      error "REDIS: #{e}"
    end
    
    
  end
end