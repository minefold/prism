require 'targz'
require 'tmpdir'

class MapError < StandardError; end

module Job
  class MapWorld
    @queue = :worlds_to_map
    
    def self.storage
      Storage.new
    end
    
    def self.map_world world_data_path, tile_path
      Dir.chdir File.dirname(File.expand_path(MAPPER)) do
        cmd = "#{MAPPER} -B 2 -T 16 -i #{world_data_path} -o #{tile_path} -h 1"
        puts "#{cmd}"
      
        result = `#{cmd}`
        puts result
        raise MapError, result unless $?.success?
      end
    end
  
    def self.perform world_id
      base_path = "#{Dir.tmpdir}/#{world_id}"
      puts "starting map_world:#{world_id} in #{base_path}"
      filename = "#{world_id}.tar.gz"
      archive_file = "#{base_path}/#{filename}"
      
      FileUtils.mkdir_p base_path
      
      Dir.chdir base_path do
        # remote_tiles_files = storage.world_tiles.files.all(:prefix => world_id)
        # if remote_tiles_files
        #   puts "Downloading #{remote_tiles_files.size} world tiles"
        #   files = remote_tiles_files.reject{|f| f.key.end_with? "/" }
        #   Parallel.each(files, in_processes:4) do |remote_tile_file|
        #     filename = remote_tile_file.key
        # 
        #     FileUtils.mkdir_p File.dirname(filename)
        #     File.open(filename, 'w') {|local_file| local_file.write(remote_tile_file.body)}
        #   end
        # end
        
        # puts "downloading world archive:#{filename}"
        # remote_file = storage.worlds.files.get filename
        # File.open(archive_file, 'w') {|local_file| local_file.write(remote_file.body)}
        # puts "world archive downloaded: #{File.new(archive_file).size / 1024 / 1024} Mb"
        #       
        # puts "extracting #{archive_file}"
        # TarGz.new.extract archive_file
        
        world_data_path = "#{base_path}/#{world_id}/#{world_id}"
        tile_path = "#{base_path}/tiles"

        map_world world_data_path, tile_path

        files = Dir["#{tile_path}/**/*"].reject{|f| File.directory? f }
        puts "uploading #{files.size} tiles"
        
        Parallel.each(files, in_processes:4) do |file|
          i ||= 0
          remote_file = file.gsub "#{tile_path}/", ""
          remote_file = "#{world_id}/#{remote_file}"
          storage.world_tiles.files.create key:remote_file, body:File.open(file), public:true
          i += 1
          puts "#{i} tiles uploaded" if i % 1000 == 0
        end
        
        puts "mapping completed"
      end
    end
  end
end