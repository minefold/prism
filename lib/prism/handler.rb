module Prism
  class Handler
    attr_reader :connection

    def init; end
    def receive_data data; end    

    def initialize connection, *args
      @connection = connection
      init *args
    end
    
    def change_handler &blk
      @on_change_handler = blk
    end
    
    def new_handler klass, *args
      @on_change_handler.call klass, *args
    end
  end
end