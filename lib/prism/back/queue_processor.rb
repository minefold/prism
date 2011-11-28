module Prism
  class QueuePopper
    include Debugger
    
    def initialize queue, *a, &b
      @queue = queue
      @callback = EM::Callback(*a, &b)

      start_processing
    end
    
    def start_processing
      debug "processing #{@queue}"
      @redis = PrismRedis.connect
      listen
    end
    
    def listen
      @pop = @redis.brpop @queue, 30
      @pop.callback do |channel, item|
        if item
          @callback.call item
        end
        
        EM.add_timer(0.5) { listen }
      end
      @pop.errback { EM.add_timer(0.5) { listen } }
    end
  end
  
  class QueueProcessor
    include Debugger
    
    def initialize klass
      @queue, @klass = klass.queue, klass

      start_processing
    end
    
    def start_processing
      debug "processing #{@queue}"
      @redis = PrismRedis.connect
      listen
    end
    
    def listen
      @pop = @redis.brpop @queue, 30
      @pop.callback do |channel, item|
        if item
          @klass.new.process item
        end
        
        EM.next_tick { listen }
      end
      @pop.errback { EM.next_tick { listen } }
    end
  end
end