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
      attr_reader :instance_id, :host, :started_at
      
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
    
  end
end