module Prism
  class QueueProcessor
    include Debugger
    
    def initialize queue, klass = nil, &blk
      @queue, @klass, @blk = queue, klass, blk

      start_processing
    end
    
    def start_processing
      debug "processing #{@queue}"
      @redis = EM::Hiredis.connect
      @redis.callback { listen }
    end
    
    def listen
      @pop = @redis.blpop @queue, 0
      @pop.callback do |channel, item|
        debug "recv #{@queue} #{item}"
        if @klass
          @klass.new item
        else
          @blk.call item
        end
        listen
      end
    end
  end
end