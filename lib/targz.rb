class TarGz
  attr_reader :options
  
  def self.new options = {}
    if RUBY_PLATFORM =~ /darwin/i
      OSX.new options
    elsif RUBY_PLATFORM =~ /linux/i
      Linux.new options
    else
      raise "Windows!? WTF!"
    end
  end
  
  class Base
    attr_reader :options
    def initialize options = {}
      @options = { sudo:false }.merge(options)
    end
    
    def sudo_cmd
      ENV['rvm_version'] ? 'rvmsudo' : 'sudo'
    end

    def sudo cmd
      `#{sudo_cmd} #{cmd}`
    end
    
    def run_command cmd
      if options[:sudo]
        sudo cmd
      else
        `#{cmd}`
      end
    end
    
    def archive path, output_file, options = {}
      run_command "tar -czf #{option_string(options)} '#{output_file}' '#{path}'"
    end
    
    def extract archive_file, options = {}
      run_command "tar -xzf #{option_string(options)} '#{archive_file}'"
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