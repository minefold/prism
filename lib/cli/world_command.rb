
class WorldCommand
  attr_reader :world_id
  
  def initialize world_id
    @world_id = world_id
  end
  
  def show
    puts Hirb::Helpers::AutoTable.render(world)
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
end

