
class WorldCommand
  attr_reader :world_id
  
  def initialize world_id
    @world_id = world_id
  end
  
  def show
    puts Hirb::Helpers::AutoTable.render(world)
  end
  
  def download
    world_filename = "#{world_id}.tar.gz"
    remote_file = storage.directories.get('minefold.worlds').files.get(world_filename)
    File.open(world_filename, 'w') {|local_file| local_file.write(remote_file.body)}
  end
  
  
  private
  
  def worlds
    MinefoldDb.connection['worlds']
  end
  
  def world
    worlds.find_one({"_id" => BSON::ObjectId(world_id)}).select{|k,v| columns.include? k }
  end
  
  def columns
    @columns ||= %w[_id slug name chat_messages]
  end
  
  def storage
    @storage ||= Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_secret_access_key    => EC2_SECRET_KEY,
      :aws_access_key_id        => EC2_ACCESS_KEY
    })
  end
  
end

