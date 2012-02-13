require 'fog'

class Storage
  class << self; attr_accessor :provider; end
  
  def self.worlds
    new provider.directories.create(:key => WORLDS_BUCKET, :public => false)
  end
  
  def self.game_servers
    new provider.directories.create(:key => "minefold-runpacks", :public => false)
  end
  
  attr_reader :directory
  
  def initialize directory
    @directory = directory
  end
  
  def download remote_file, local_file
    key = nil
    File.open(local_file, File::RDWR|File::CREAT) do |local| 
      key = directory.files.get(remote_file) do |chunk, remaining_bytes, total_bytes| 
        local.write chunk
      end 
    end
    local_file if key
  end
  
  def upload local_file, remote_file, options = {}
    File.open(local_file) do |file|
      directory.files.create({key: remote_file, body: file}.merge(options))
    end
  end
end  