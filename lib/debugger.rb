module Debugger
  def debug *data
    puts tagged_message(data.join(" "))
  end

  def info tag=nil, message
    message = tag unless tag
    puts tagged_message(message, tag)
  end

  def error message, error = nil
    puts tagged_message("ERROR: #{message}\n#{error}")
  end

  def tagged_message message, tag = nil
    @tag = (Array(log_tag) + Array(tag)).compact
    if @tag.any?
      "[#{@tag.join('|')}] #{message}"
    else
      message
    end
  end

  def log_tag
  end

end