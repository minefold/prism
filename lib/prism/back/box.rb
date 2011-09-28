module Prism
  module WorldCollector
    def initialize df
      @df = df
    end
    
    def post_init
      send_data "worlds"
    end
    
    def receive_data data
      @world_data = JSON.parse data
      @df.succeed @world_data
      close_connection
    end
    
    def unbind
      @df.fail unless @world_data
    end
  end
  
  
  module Box
    def self.box_class
      case Fold.workers
      when :local
        Local
      when :cloud
        Cloud
      end
    end
    
    def self.create options = {}
      box_class.create options
    end
    
    def self.all *c, &b
      box_class.all *c, &b
    end
    
    class Base
      attr_reader :instance_id, :host, :state, :started_at
      
      def running?
        state == 'running'
      end
      
      def query_worlds
        df = EM::DefaultDeferrable.new
        begin
          c = EM.connect host, 3000, WorldCollector, df
          c.pending_connect_timeout = 2
        rescue => e
          df.fail e
        end
        df
      end
    end
    
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
        @instance_id, @host = instance_id, '0.0.0.0'
        @state = 'running'
        @started_at = Time.now
      end
    end
    
    
  end
end