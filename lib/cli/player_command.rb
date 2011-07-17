
class PlayerCommand
  attr_reader :username
  
  def initialize username
    @username = username
  end
  
  def show
    puts Hirb::Helpers::AutoTable.render(player)
  end
  
  def add_minutes amount
    amount = amount.to_i
    users.update({"username" => username}, {"$inc" => {"minutes_remaining" => amount}}, {"safe" => true})
  end
  
  private
  
  def users
    MinefoldDb.connection['users']
  end
  
  def player
    users.find_one({"username" => username}).select{|k,v| columns.include? k }
  end
  
  def columns
    @columns ||= %w[_id username email world_id minutes_remaining]
  end
end

