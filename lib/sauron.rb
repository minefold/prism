require 'minefold'

class SupervisedWorld
  attr_accessor :supervised_worker, :world, :state
  
  def initialize state, supervised_worker = nil, world = nil
    @supervised_worker, @world, @state = supervised_worker, world, state
  end
  
  def running_worker?
    supervised_worker && supervised_worker.running?
  end
  
  def running?
    state == :running
  end
  
  def inspect
    "#<#{self.class} supervised_worker:#{supervised_worker.inspect} state:#{state}>"
  end
end

class SupervisedWorker
  attr_accessor :worker, :state

  def initialize state, worker = nil
    @worker, @state = worker, state
  end
  
  def running?
    state == :running
  end
  
  def stopped?
    state == :stopped
  end
  
  def ==(other)
    return false unless self.worker and other.worker
    
    self.worker.instance_id == other.worker.instance_id
  end
  
  def inspect
    "#<#{self.class} worker:#{worker.instance_id} state:#{state}>"
  end
end
