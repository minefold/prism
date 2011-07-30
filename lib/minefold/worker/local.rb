module Worker
  class LocalVM
    attr_reader :id, :state, :created_at
    
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
        worker
      end

      def find instance_id
        virtual_workers.find {|w| w.instance_id == instance_id }
      end
      
      def virtual_workers
        @@virtual_workers ||= begin
          worker = Local.new LocalVM.create
          LocalWorld.running.each{|local_world| worker.worlds << World.new(worker, local_world.id, local_world.port) }
          [worker]
        end
      end
      
    end
    
    attr_reader :server, :worlds
    
    def initialize server
      @server = server
      @worlds = []
    end
    
    def start!
      server.state = 'running'
      self
    end

    def stop!
      server.state = 'stopped'
      self
    end

    def terminate!
      virtual_servers.delete server
      nil
    end

    def world world_id
      worlds.find{|w| w.id == world_id}
    end

    def responding?
      true
    end

    def start_world world_id, min_heap_size, max_heap_size
      `echo #{Fold.env} > ~/FOLD_ENV`
      `echo #{Fold.worker_user} > ~/FOLD_WORKER_USER`
      
      result = `#{BIN}/start-local-world #{world_id} #{min_heap_size} #{max_heap_size}`
      if $?.exitstatus != 0
        puts result
        raise result
      end
      
      local_world = LocalWorld.running.find{|local_world| local_world.id == world_id}
      w = World.new self, local_world[:id], local_world[:port]
      worlds << w
      w
    end

    def stop_world world_id
      result = `#{BIN}/stop-local-world #{world_id}`
      if $?.exitstatus != 0
        puts result
        raise result
      end
    end
    
  end
end