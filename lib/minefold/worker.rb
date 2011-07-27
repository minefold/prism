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
    
    def uptime_minutes
      ((Time.now - server.created_at) / 60).floor
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