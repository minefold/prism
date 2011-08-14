require 'targz'
require 'tmpdir'

class MapError < StandardError; end

module Job
  class MapWorld
    extend Resque::Plugins::Lock
    include Resque::Plugins::UniqueJob
    
    @queue = :worlds_to_map
    
    def self.storage
      Storage.new
    end
    
    def self.run_command cmd
      puts "#{cmd}"
      result = `#{cmd}`
      puts result
      result
    end
    
    def self.map_world world_id, world_data_path, tile_path
      Dir.chdir File.dirname(File.expand_path(MAPPER)) do
        result = nil
        
        last_map_run = storage.world_tiles.files.get("#{world_id}/last_map_run")
        if last_map_run
          puts "incremental map generation"
          last_run_path = "#{tile_path}/last_map_run"

          download last_run_path, last_map_run
          download "#{tile_path}/pigmap.params", storage.world_tiles.files.get("#{world_id}/pigmap.params")
          run_command "touch -t $(cat #{last_run_path}) #{last_run_path} && find #{world_data_path} -newer #{last_run_path} > #{world_data_path}/map_changes"
          result = run_command "#{MAPPER} -h 1 -r #{world_data_path}/map_changes  -i #{world_data_path} -o #{tile_path}"
        else
          puts "full map generation"
          result = run_command "#{MAPPER} -h 1 -B 4 -T 4 -i #{world_data_path} -o #{tile_path}"
        end
        
        raise MapError, result unless $?.success?
      end

      # create a file with the latest modification date of the world
      last_modified_time = Dir['**/*'].select{|f| File.file? f }.map{|f| File.mtime f }.sort.last
      puts "last map modification:#{last_modified_time.strftime('%Y-%m-%d %H:%M.%S')}"
      run_command "echo '#{last_modified_time.strftime("%Y%m%d%H%M.%S")}' > #{tile_path}/last_map_run"
    end
    
    def self.download local_file, remote_file
      File.open(local_file, 'w') {|local_file| local_file.write(remote_file.body)}
    end
  
    def self.perform world_id
      base_path = "#{Dir.tmpdir}/#{world_id}"
      filename = "#{world_id}.tar.gz"
      archive_file = "#{base_path}/#{filename}"
      world_data_path = "#{base_path}/#{world_id}/#{world_id}"
      tile_path = "#{base_path}/tiles"

      puts "starting map_world:#{world_id} in #{base_path}"
      
      FileUtils.mkdir_p base_path
      FileUtils.rm_rf tile_path
      FileUtils.mkdir_p tile_path
      
      Dir.chdir base_path do
        puts "downloading world archive:#{filename}"
        download archive_file, storage.worlds.files.get(filename)
        puts "world archive downloaded: #{File.new(archive_file).size / 1024 / 1024} Mb"
              
        puts "extracting #{archive_file}"
        TarGz.new.extract archive_file
        
        map_world world_id, world_data_path, tile_path

        files = Dir["#{tile_path}/**/*"].reject{|f| File.directory? f }
        puts "uploading #{files.size} tiles"
        
        Parallel.each(files, in_processes:4) do |file|
          remote_file_path = file.gsub "#{tile_path}/", ""
          remote_file_path = "#{world_id}/#{remote_file_path}"
          
          storage.world_tiles.files.create key:remote_file_path, body:File.open(file), public:true
        end
        
        puts "mapping completed"
      end
    end
  end
end