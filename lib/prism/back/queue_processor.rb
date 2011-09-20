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
      @pop = @redis.blpop @queue, 0
      @pop.callback do |channel, item|
        debug "recv #{@queue} #{item}"
        @klass.new.process item

        listen
      end
    end
  end
end