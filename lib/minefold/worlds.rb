class Worlds < Array
  attr_reader :worker

  def initialize worker, worlds = []
    @worker = worker
    worlds.each {|w| self << w }
  end
end