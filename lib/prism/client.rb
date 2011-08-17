module Prism
  module Client
    include Debugger
    
    attr_reader :handler
        
    def post_init
      set_handler UnknownPlayerHandler
    end
    
    def set_handler klass, *args
      debug "handler > #{klass} #{args.join(', ')}"
      
      @handler = klass.new self, *args
      handler.change_handler { |klass, *args| set_handler klass, *args }
    end
        
    def receive_data data
      handler.receive_data data
    end
  end
end
