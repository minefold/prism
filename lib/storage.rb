require 'fog'

class Storage
  attr_reader :connection
  
  def initialize
    @connection = Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_secret_access_key    => EC2_SECRET_KEY,
      :aws_access_key_id        => EC2_ACCESS_KEY
    })
  end
  
  def worlds
    connection.directories.create(
      :key    => "minefold.worlds", # globally unique name
      :public => false
    )
  end
end  