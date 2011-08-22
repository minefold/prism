module Debugger
  def debug *data
    puts tagged_message(data.join(" "))
  end

  def info message
    puts tagged_message(message)
  end

  def error message, error = nil
    puts tagged_message("ERROR: #{message}\n#{error}")
  end

  def tagged_message message
    @tag ||= Array(log_tag)
    if @tag.any?
      "[#{@tag.join('|')}] #{message}"
    else
      message
    end
  end

  def log_tag
  end

end