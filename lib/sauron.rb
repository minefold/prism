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

# class SupervisedWorker
#   attr_accessor :worker, :state
# 
#   def initialize state, worker = nil
#     @worker, @state = worker, state
#   end
#   
#   [:starting, :starting_world, :stopping_world, :stopping].each do |state|
#     define_method :"#{state}?" { self.state == state }
#     define_method :"#{state}!" { self.state = state }
#   end
#   
#   def ==(other)
#     return false unless self.worker and other.worker
#     
#     self.worker.instance_id == other.worker.instance_id
#   end
#   
#   def inspect
#     "#<#{self.class} worker:#{worker.instance_id} state:#{state}>"
#   end
# end
