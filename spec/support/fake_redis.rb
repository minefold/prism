module EM
  class FakeRedis
    class << self
      attr_accessor :internal_lists, :internal_sets, :internal_subscriptions, :internal_published, :internal_hashes
    end
    
    attr_reader :active_subscription
    
    def self.reset
      self.internal_lists = {}
      self.internal_sets = {}
      self.internal_hashes = {}
      self.internal_subscriptions = {}
      self.internal_published = {}
    end
    
    def self.publish channel, value
      internal_subscriptions[channel].each {|s| s.callback channel, value }
    end
    
    def internal_lists; self.class.internal_lists; end
    def internal_sets; self.class.internal_sets; end
    def internal_hashes; self.class.internal_hashes; end
    def internal_subscriptions; self.class.internal_subscriptions; end
    def internal_published; self.class.internal_published; end
    
    def callback &blk
      yield self
    end
    
    def errback
    end
    
    
    # list methods
    def lpush list, value
      internal_lists[list] ||= []
      internal_lists[list] << value
      op value
    end
    
    # set methods
    def smembers set
      op(internal_sets[set] || [])
    end
    
    def srem set, member
      op internal_sets[set].delete member
    end
    
    def scard set
      op internal_sets[set].size
    end
    
    # hash methods
    def hgetall hash
      op (internal_hashes[hash] || {}).map{|k,v| [k,v] }.flatten
    end
    
    def hget hash, key
      op internal_hashes[hash] ? internal_hashes[hash][key] : nil
    end
    
    def hset hash, key, value
      internal_hashes[hash] ||= {}
      internal_hashes[hash][key] = value
      op value
    end
    
    def hdel hash, key
      op internal_hashes[hash].delete(key)
    end
    
    def publish channel, value
      internal_published[channel] ||= []
      internal_published[channel] << value
      
      if internal_subscriptions[channel]
        internal_subscriptions[channel].each {|s| s}
      end
    end
    
    def subscribe channel
      @active_subscription_channel = channel
    end
    
    def unsubscribe channel
      @active_subscription_channel = nil
    end
    
    def on event, &blk
      internal_subscriptions[@active_subscription_channel] ||= []
      internal_subscriptions[@active_subscription_channel] << FakeRedisSubscription.new(blk)
    end
    
    private
    
    def op value
      FakeRedisOperation.new value
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
    
    def errback
      
    end
  end
end