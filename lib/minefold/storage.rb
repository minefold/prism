require 'fog'

class Storage
  attr_reader :storage_cloud
  
  def initialize
    @storage_cloud = Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_secret_access_key    => EC2_SECRET_KEY,
      :aws_access_key_id        => EC2_ACCESS_KEY
    })
  end
  
  def worlds
    storage_cloud.directories.create(
      :key    => "minefold.worlds", # globally unique name
      :public => false
    )
  end
end  