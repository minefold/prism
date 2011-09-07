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
  
  module Redis
    def self.subscribe_once channel, &blk
      RedisOneShotSubscription.new Prism.hiredis_connect, channel, &blk
    end
    
    def self.subscribe_once_json channel, &blk
      RedisOneShotSubscription.new(Prism.hiredis_connect, channel) { |message| blk.call JSON.parse message }
    end
  end
  
  class RedisOneShotSubscription
    include Debugger
    
    attr_reader :connection, :channel
    
    def initialize connection, channel, &blk
      @connection, @channel = connection, channel
      @connection.errback {|e| error "failed to connect to redis: #{e}" }

      debug "√ #{hex(connection.object_id)}:#{channel}"
      @connection.subscribe channel
      @connection.on :message do |channel, response|
        unless @cancelled
          cancel
          debug "• #{hex(connection.object_id)}:#{channel} > #{response}"
          blk.call response
        end
      end
    end
    
    def cancel
      @cancelled = true
      debug "× #{hex(connection.object_id)}:#{channel}"
      op = connection.unsubscribe channel
      op.callback { connection.close_connection }
    end
    
    def hex num
      "0x%02X" % num
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
      op = redis.hget key, field
      op.errback {|e| handle_error e }
      op.callback {|data| yield data ? JSON.parse(data) : nil }
    end
    
    def hset_hash channel, key, value
      op = redis.hset channel, key, value.to_json
      op.errback {|e| handle_error e }
      op
    end
    
    def publish_json channel, hash
      publish channel, hash.to_json
    end
    
    def method_missing sym, *args, &blk
      redis.send sym, *args, &blk
    end
    
    def handle_error e
      error "REDIS ERROR: #{e}"
    end
    
    
  end
end