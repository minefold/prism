module Prism
  class Handler
    include Debugger
    
    attr_reader :connection, :buffered_data, :connection_active, :redis

    def init; end
    def exit; end
    def receive_data data; end

    def initialize connection, *args
      @connection = connection
      @connection_active = true
      @redis = Prism.redis
      init *args
    end
    
    def change_handler &blk
      @on_change_handler = blk
    end
    
    def new_handler klass, *args
      exit
      @on_change_handler.call klass, *args
    end
    
    def unbind
      debug "client disconnected"
      @connection_active = false
      exit
    end    
  end
end