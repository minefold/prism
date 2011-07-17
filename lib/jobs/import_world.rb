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

class InvalidArchive < StandardError; end
class InvalidWorld < StandardError; end

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
      begin
        import_path = FileUtils.mkdir_p("#{base_path}/import").last
        extract_path = FileUtils.mkdir_p("#{base_path}/extract").last
        Dir.chdir extract_path do
          puts "Downloading #{filename} => #{File.expand_path(filename)}"

          remote_file = storage.directories.get('minefold.import').files.get filename
          File.open(filename, 'w') {|local_file| local_file.write(remote_file.body)}

          puts "Extracting..."
          extract_archive filename
          world_path = find_world_path
          raise InvalidWorld unless world_path

          puts "Found world data"
          FileUtils.rm "#{world_path}/server.jar" if File.exists? "#{world_path}/server.jar"
        
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
          
          update_world_status world_id, ''
          remote_file.destroy
        end
      rescue InvalidArchive
        update_world_status world_id, 'invalid_archive'
      rescue InvalidWorld
        update_world_status world_id, 'invalid_world'
      ensure
        FileUtils.rm_rf base_path
        puts "Complete"
      end
    end
  
    def self.extract_archive filename
      # right now we just assume it's a zip file
      `unzip #{filename}`
      raise InvalidArchive unless $?.success?
    end
  
    def self.find_world_path
      puts Dir["**/*"].join("\n")
      region_path = Dir["**/*"].find{|dir| dir =~ /([^\/]+)\/region\/r\.0\.0\.mcr/ }
      if region_path
        world_name = $1
        world_path = File.expand_path(region_path).gsub "/#{world_name}/region/r.0.0.mcr", ""
      end
    end
    
    def self.update_world_status world_id, status
      connection = MinefoldDb.connection

      worlds = connection['worlds']
      worlds.update({'_id' => BSON::ObjectId(world_id)}, {"$set" => { "status" => status }})
    end
  end
end