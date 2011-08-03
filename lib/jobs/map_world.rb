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
      mapper = "#{ROOT}/vendor/overviewer/overviewer.py"
      cmd = "#{mapper} --processes=1 --rendermodes=lighting #{world_data_path} #{tile_path}"
      puts "#{cmd}"
      
      result = `#{cmd}`
      raise MapError, result unless $?.success?
    end
  
    def self.perform world_id
      puts "starting map_world:#{world_id}"
      base_path = "#{Dir.tmpdir}/#{world_id}"
      filename = "#{world_id}.tar.gz"
      archive_file = "#{base_path}/#{filename}"
      
      FileUtils.mkdir_p base_path
      
      Dir.chdir base_path do
        puts "downloading world archive:#{filename} => #{archive_file}"
        remote_file = storage.worlds.files.get filename
        File.open(archive_file, 'w') {|local_file| local_file.write(remote_file.body)}
        puts "world archive downloaded: #{File.new(archive_file).size / 1024 / 1024} Mb"
      
        puts "Downloading world tiles"
        tiles_bucket = storage.world_tiles
        remote_tiles_files = tiles_bucket.files.all(:prefix => world_id)
        if remote_tiles_files
          remote_tiles_files.reject{|f| f.key.end_with? "/" }.each do |remote_tile_file|
            filename = remote_tile_file.key
            puts "#{filename}"

            FileUtils.mkdir_p File.dirname(filename)
            File.open(filename, 'w') {|local_file| local_file.write(remote_tile_file.body)}
          end
        end
      
        puts "extracting #{archive_file}"
        TarGz.new.extract archive_file
        
        world_data_path = "#{base_path}/#{world_id}/#{world_id}"
        tile_path = "#{base_path}/tiles"

        map_world world_data_path, tile_path

        puts "uploading tiles:#{tile_path}"
        Dir["#{tile_path}/**/*"].reject{|f| File.directory? f }.each do |file|
          remote_file = file.gsub "#{tile_path}/", ""
          remote_file = "#{world_id}/#{remote_file}"
          print "."
          tiles_bucket.files.create key:remote_file, body:File.open(file), public:true
        end
        
        puts "mapping completed"
      end
    end
  end
end