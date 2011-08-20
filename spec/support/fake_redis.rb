module EM
  module Hiredis
    def self.connect
      FakeRedis.new
    end
  end
  
  class FakeRedis
    class << self
      attr_accessor :lists, :subscriptions, :internal_published, :internal_hashes
    end
    
    attr_reader :active_subscription
    
    def self.reset
      self.lists = {}
      self.subscriptions = {}
      self.internal_published = {}
      self.internal_hashes = {}
    end
    
    def self.publish channel, value
      subscriptions[channel].each {|s| s.callback channel, value }
    end
    
    def lists
      self.class.lists
    end
    
    def subscriptions
      self.class.subscriptions
    end

    def internal_hashes
      self.class.internal_hashes
    end
    
    def internal_published
      self.class.internal_published
    end
    
    def callback
      yield self
    end
    
    def lpush list, value
      lists[list] ||= []
      lists[list] << value
    end
    
    def hget hash, key
      FakeRedisOperation.new internal_hashes[hash][key]
    end
    
    def hset hash, key, value
      internal_hashes[hash] ||= {}
      internal_hashes[hash][key] = value
    end
    
    def publish channel, value
      internal_published[channel] ||= []
      internal_published[channel] << value
      
      if subscriptions[channel]
        subscriptions[channel].each {|s| s}
      end
    end
    
    def subscribe channel
      @active_subscription_channel = channel
    end
    
    def on event, &blk
      subscriptions[@active_subscription_channel] ||= []
      subscriptions[@active_subscription_channel] << FakeRedisSubscription.new(blk)
    end
  end
  
  
  class FakeRedisSubscription
    def initialize blk
      @blk = blk
    end
    
    def callback *args
      @blk.call *args
    end
  end
  
  class FakeRedisOperation
    def initialize value
      @value = value
    end
    
    def callback
      yield @value
    end
  end
end