module Debugger
  def debug *data
    puts tagged_message(data.join(" "))
  end

  def info tag, message = nil
    unless message
      message = tag
      tag = nil
    end
    puts tagged_message(message, tag)
  end

  def error message, error = nil
    puts tagged_message("ERROR: #{message}\n#{error}")
  end

  def tagged_message message, tag = nil
    @tag = (Array(tag) | Array(self.class.info_tag && self.class.info_tag.call)).compact
    if @tag.any?
      "[#{@tag.join('|')}] #{message}"
    else
      message
    end
  end

  def self.included klass
    klass.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :info_tag

    def info_tag &blk
      @info_tag = blk
    end
  end
end