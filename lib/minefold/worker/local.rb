module Worker
  class LocalVM
    attr_reader :id, :created_at
    attr_accessor :state
    
    def self.next_index
      @@index ||= 0
      @@index += 1
      @@index
    end
    
    def self.create
      self.new "i-local-#{next_index}"
    end
    
    def initialize id
      @id = id
      @state = 'running'
      @created_at = Time.now
    end
    
    def public_ip_address
      "0.0.0.0"
    end
  end
  
  class Local < Base
    class << self
      
      def all
        virtual_workers
      end

      def create options = {}
        worker = Local.new LocalVM.create
        virtual_workers << worker
        worker.start!
        worker
      end

      def find instance_id
        virtual_workers.find {|w| w.instance_id == instance_id }
      end
      
      def virtual_workers
        @@virtual_workers ||= begin
          response = HTTParty.get("http://0.0.0.0:3000") rescue nil
          if response
            [Local.new(LocalVM.create)]
          else
            []
          end
        end
      end
      
    end
    
    include GodHelpers
    attr_reader :server, :worlds
    
    def initialize server
      @server = server
      @worlds = []
    end
    
    def start!
      god_start "#{ROOT}/worker/config/worker.god", "worker-app"
      wait_for_worker_ready
      server.state = 'running'
      self
    end

    def stop!
      god_stop "worker-app"
      server.state = 'stopped'
      self
    end

    def terminate!
      god_stop "worker-app"
      virtual_servers.delete server
      nil
    end
  end
end