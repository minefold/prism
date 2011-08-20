module Prism
  class Request
    include Debugger
    include Redis
    
    class << self
      attr_reader :arguments
      def message_arguments *args
        @arguments = args
      end
    end
    
    def process message
      args = [message]
      
      if self.class.arguments
        data = JSON.parse message
        
        args = self.class.arguments.map {|a| data[a.to_s] }
      end
      
      args.each
      
      run *args
    end
  end
end