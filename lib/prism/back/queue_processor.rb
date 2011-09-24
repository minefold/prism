module Prism
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
      @pop = @redis.blpop @queue, 30
      @pop.callback do |channel, item|
        if item
          debug "recv #{@queue} #{item}"
          @klass.new.process item
        end
        
        EM.next_tick { listen }
      end
    end
  end
end