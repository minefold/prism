require 'fog'

class Storage
  class << self; attr_accessor :provider; end
    
  def worlds
    
    Storage.provider.directories.create(
      :key    => "minefold.worlds", # globally unique name
      :public => false
    )
  end
end  