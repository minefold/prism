module Prism
  class Handler
    include Debugger
    
    attr_reader :connection, :buffered_data, :redis

    def init; end
    def exit; end
    def receive_data data; end
    def client_unbound; end

    def initialize connection, *args
      @connection = connection
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
    
    def send_data data
      connection.send_data data
    end
    
    def unbind
      client_unbound
      exit
    end    
  end
end