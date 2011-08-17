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
    
    def self.reset
      self.lists = {}
      self.subscriptions = {}
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
      subscriptions[channel] ||= []
      subscriptions[channel] << self
    end
  end
end