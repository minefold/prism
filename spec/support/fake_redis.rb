module EM
  module Hiredis
    def self.connect
      FakeRedis.new
    end
  end
  
  class FakeRedis
    class << self
      attr_accessor :lists
      attr_accessor :subscriptions
    end
    
    attr_reader :active_subscription
    
    def self.reset
      self.lists = {}
      self.subscriptions = {}
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
    
    def callback
      yield
    end
    
    def lpush list, value
      lists[list] ||= []
      lists[list] << value
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
end