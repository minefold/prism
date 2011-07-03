class World
  attr_reader :worker, :id, :port
  attr_accessor :state

  # TODO: Redesign interface. Options should really be loaded from Mongo
  #       (after being set in the web interface).
  def initialize worker, id, port, opts={}
    @worker, @id, @port, @options = worker, id, port, opts
  end
end