module Prism
  class Request
    include Debugger
    
    include Redis
    include Mongo
    
    class << self
      attr_reader :queue, :message_parts
      
      def process queue = nil, *message_parts
        
        @queue, @message_parts = queue, message_parts
        
        message_parts.each {|part| self.__send__(:attr_reader, "#{part}") }
      end
    end
    
    attr_reader :redis
    
    def process message
      parts = self.class.message_parts.size == 1 ? { self.class.message_parts.first => message } : JSON.parse(message)
      
      parts.each{|k,v| self.instance_variable_set(:"@#{k}", v) }
      
      redis_connect do |redis|
        @redis = redis
        run
      end
    end
  end
end