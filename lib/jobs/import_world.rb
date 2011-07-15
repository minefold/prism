require 'tmpdir'

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
  end
  
  class OSX < Base
    def option_string options
      options.map{|k,v| "--#{k} '#{v}'"}
    end
  end
  
  class Linux < Base
    def option_string options
      options.map{|k,v| "--#{k}='#{v}'"}
    end
  end
end

module Job
  class ImportWorld
    @queue = :worlds_to_import
  
    def self.storage
      @storage ||= Fog::Storage.new({
        :provider                 => 'AWS',
        :aws_secret_access_key    => EC2_SECRET_KEY,
        :aws_access_key_id        => EC2_ACCESS_KEY
      })
    end
  
    def self.perform world_id, filename
      base_path = "#{Dir.tmpdir}/#{world_id}"
      import_path = FileUtils.mkdir_p("#{base_path}/import").last
      extract_path = FileUtils.mkdir_p("#{base_path}/extract").last
      Dir.chdir extract_path do
        puts "Downloading #{filename} => #{File.expand_path(filename)}"

        remote_file = storage.directories.get('minefold.import').files.get filename
        File.open(filename, 'w') {|local_file| local_file.write(remote_file.body)}

        puts "Extracting..."
        extract_archive filename
        world_path = find_world_path
        begin
          if world_path
            puts "Found world data"
            FileUtils.rm "#{world_path}/server.jar"
          
            FileUtils.mkdir_p "#{import_path}/#{world_id}"
            FileUtils.cp_r "#{world_path}/.", "#{import_path}/#{world_id}"
          
            Dir.chdir import_path do
              archive_filename = "#{world_id}.tar.gz"
              archive_path = File.expand_path archive_filename
              puts "Rearchiving to #{archive_path}"
              
              TarGz.new.archive world_id, archive_path
              
              puts "Uploading #{archive_filename}"
              directory = storage.directories.get('minefold.worlds')
              directory.files.create(
                :key    => archive_filename,
                :body   => File.open(archive_path),
                :public => false
              )
            end
          else
            raise "Invalid world"
          end
        ensure
          FileUtils.rm_rf base_path
        end
      end
    end
  
    def self.extract_archive filename
      # right now we just assume it's a zip file
      `unzip #{filename}`
    end
  
    def self.find_world_path
      region_path = Dir["**/*"].find{|dir| dir =~ /(\w+)\/DIM-1\/region/ }
      if region_path
        world_name = $1
        world_path = File.expand_path(region_path).gsub "/#{world_name}/DIM-1/region", ""
      end
    end
  end
end