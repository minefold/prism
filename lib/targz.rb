class TarGz
  attr_reader :options
  
  def self.new
    if RUBY_PLATFORM =~ /darwin/i
      OSX.new
    elsif RUBY_PLATFORM =~ /linux/i
      Linux.new
    else
      raise "Windows!? WTF!"
    end
  end
  
  class Base
    def archive path, output_file, options = {}
      cmd = "tar -czf '#{output_file}' '#{path}' #{option_string(options)}"
      puts `#{cmd}`
    end
    
    def extract archive_file, options = {}
      cmd = "tar -xzf '#{archive_file}' #{option_string(options)}"
      puts `#{cmd}`
    end
  end
  
  class OSX < Base
    def option_string options
      options.map{|k,v| "--#{k} '#{v}'"}.join(" ")
    end
  end
  
  class Linux < Base
    def option_string options
      options.map{|k,v| "--#{k}='#{v}'"}.join(" ")
    end
  end
end