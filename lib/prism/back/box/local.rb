module Prism
  module Box
    module LocalWidgetHandler
      def receive_data data
        puts "local: #{data}"
      end
  
      def receive_stderr data
        puts "local err: #{data}"
      end
    end

    class Local < Base
      def self.create options = {}
        @deferrable = EM::DefaultDeferrable.new
    
        if @local_box
          @deferrable.succeed @local_box
        else
          @deferrable.succeed @local_box = begin
            local_instance_id = `hostname`.strip
            puts "starting local box"
            EM.popen "#{BIN}/widget '#{local_instance_id}' '0.0.0.0'", LocalWidgetHandler
      
            Local.new local_instance_id
          end
        end
        @deferrable
      end
  
      def self.all *c, &b
        handler = EM::Callback(*c, &b)
        handler.call Array(@local_box)
      end
  
      def initialize instance_id
        @instance_id, @instance_type, @host = instance_id, 'm1.large', '0.0.0.0'
        @state = 'running'
        @started_at = Time.now
      end
      
      def query_state *c,&b
        cb = EM::Callback(*c,&b)
        cb.call 'running'
      end
      
    end
  end
end