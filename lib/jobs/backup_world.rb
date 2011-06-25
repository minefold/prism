require 'storage'
require 'fileutils'
require 'environment'

module Jobs
  class BackupWorld
    @queue = :world
    
    def self.perform world_name
      FileUtils.mkdir_p "#{ROOT}/backups"
      
      world_archive = "#{ROOT}/backups/#{world_name}.tar.gz"
      
      # tar gz world
      Dir.chdir "#{ROOT}/worlds" do
        `tar czf '#{world_archive}' '#{world_name}'`
      end
      
      directory = Storage.new.worlds
      
      # TODO: investigate streaming of this file
      file = directory.files.create(
        :key    => "#{world_name}.tar.gz",
        :body   => File.open(world_archive),
        :public => false
      )
      
      FileUtils.rm world_archive
    end
  end
end