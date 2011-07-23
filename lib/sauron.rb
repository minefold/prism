require 'minefold'

class SupervisedWorld
  attr_accessor :worker, :world, :state
  
  def initialize state, worker = nil, world = nil
    @worker, @world, @state = worker, world, state
  end
  
  [:starting, :running, :stopping].each do |state|
    define_method(:"#{state}?") { self.state == state }
    define_method(:"#{state}!") { self.state = state }
  end
  
  def inspect
    "#<#{self.class} supervised_worker:#{supervised_worker.inspect} state:#{state}>"
  end
end

