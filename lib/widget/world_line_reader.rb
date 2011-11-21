# encoding: ISO-8859-1

module Widget
  class WorldLineReader < EventMachine::FileTail
    attr_accessor :on_line
  
    def initialize(path, startpos=-1)
      super(path, startpos)
      yield self if block_given?
    end

    def receive_data(data)
      data.force_encoding('ISO-8859-1').split("\n").each {|line| on_line.call LogLine.new(line) }
    end
  end
end