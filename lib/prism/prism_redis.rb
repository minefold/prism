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
    
    def store_running_worker instance_id, host, started_at
      hset_hash "workers:running", instance_id, instance_id:instance_id, host:host, started_at:started_at
    end

    def store_running_world instance_id, world_id, host, port
      hset_hash "worlds:running", world_id, instance_id:instance_id, host:host, port:port
    end
    
    def hget_json key, field
      op = hget key, field
      op.callback {|data| yield data ? JSON.parse(data) : nil }
      op
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
    
    %w[blpop hget hgetall hset lpush publish scard sadd srem].each do |cmd|
      define_method(:"#{cmd}") do |*args| 
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