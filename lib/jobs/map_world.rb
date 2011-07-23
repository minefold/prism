require 'targz'
require 'tmpdir'

class MapError < StandardError; end

module Job
  class MapWorld
    @queue = :worlds_to_map
  
    def self.storage
      @storage ||= Fog::Storage.new({
        :provider                 => 'AWS',
        :aws_secret_access_key    => EC2_SECRET_KEY,
        :aws_access_key_id        => EC2_ACCESS_KEY
      })
    end
  
    def self.perform world_id
      base_path = "#{Dir.tmpdir}/#{world_id}"
      filename = "#{world_id}.tar.gz"
      archive_file = "#{base_path}/#{filename}"
      
      FileUtils.mkdir_p base_path
      
      Dir.chdir base_path do
        puts "Downloading world archive:#{filename} => #{archive_file}"
        unless File.exists? archive_file 
          remote_file = storage.directories.get('minefold.worlds').files.get filename
          File.open(archive_file, 'w') {|local_file| local_file.write(remote_file.body)}
        end
      
        puts "Downloading world tiles"
        tiles_bucket = storage.directories.create(key:"minefold.production.world-tiles", public:false)
        remote_tiles_files = tiles_bucket.files.all(:prefix => world_id)
        if remote_tiles_files.any?
          Parallel.each(remote_tiles_files.reject{|f| f.key.end_with? "/" }, in_threads: 10) do |remote_tile_file|
            filename = remote_tile_file.key
            puts "#{filename}"

            FileUtils.mkdir_p File.dirname(filename)
            File.open(filename, 'w') {|local_file| local_file.write(remote_tile_file.body)}
          end
        end
      
        puts "Extracting #{archive_file}"
        TarGz.new.extract archive_file
        
        world_data_path = "#{base_path}/#{world_id}/#{world_id}"
        tile_path = "#{base_path}/tiles"

        cmd = "/Users/dave/code/Minecraft-Overviewer/overviewer.py --rendermodes=lighting #{world_data_path} #{tile_path}"
        puts "#{cmd}"
        
        result = `#{cmd}`
        raise MapError, result unless $?.success?
      
        puts "Uploading tiles:#{tile_path}"
        Parrallel.each(Dir["#{tile_path}/**/*"].reject{|f| File.directory? f }, in_threads:10) do |file|
          remote_file = file.gsub "#{tile_path}/", ""
          remote_file = "#{world_id}/#{remote_file}"
          puts remote_file
          tiles_bucket.files.create key:remote_file, body:File.open(file), public:false
        end
        
        puts "Done"
      end
    end
  end
end