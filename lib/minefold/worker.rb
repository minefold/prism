module Worker
  
  class Base
    def self.running
      all.select {|w| w.server.state == 'running' }
    end

    def self.stopped
      all.select {|w| w.server.state == 'stopped' }
    end
    
    def instance_id
      server.id
    end

    def public_ip_address
      server.public_ip_address
    end
    
    def started_at
      server.created_at
    end
    
    def uptime_minutes
      ((Time.now - started_at) / 60).floor
    end
        
    def responding?
      get("/", timeout:10).body rescue false
    end
    
    def state
      server.state
    end
    
    def running?
      state == 'running'
    end
    
    def wait_for_worker_ready
      log "Waiting for worker to respond"
      Timeout::timeout(20) do
        begin
          get("/", timeout:2).body
        rescue Errno::ECONNREFUSED
          sleep 1
          retry
        rescue Timeout::Error
          retry
        end
      end
    end
    
    
    def get path, options={}
      self.class.base_uri url
      self.class.get path, options
    end

    def uri
      @uri ||= URI.parse url
    end

    def log message
      puts "[#{instance_id}] #{message}"
    end
    
  end
  
  
  class << self
    [:all, :running, :stopped, :create, :find].each do |method|
      define_method(:"#{method}") {|*args| delegate.send method, *args }
    end
    
    def delegate
      @@delegate ||= case Fold.workers
      when :local
        Local
      when :cloud
        Cloud
      end
    end
  end
end

require 'minefold/worker/cloud'
require 'minefold/worker/local'