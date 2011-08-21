module Debugger
  def debug *data
    puts data.join(" ")
  end

  def info message
    puts message
  end
  
  def error message, error = nil
    puts "ERROR: #{message}\n#{error}"
  end
end