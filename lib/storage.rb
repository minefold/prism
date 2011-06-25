class Storage
  attr_reader :connection
  
  def initialize
    @connection = Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_secret_access_key    => ENV['EC2_SECRET_KEY'],
      :aws_access_key_id        => ENV['EC2_ACCESS_KEY']
    })
  end
  
  def worlds
    connection.directories.create(
      :key    => "minefold.worlds", # globally unique name
      :public => false
    )
  end
end  