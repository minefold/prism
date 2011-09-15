require 'fog'

class Storage
  class << self; attr_accessor :provider; end
    
  def worlds
    Storage.provider.directories.create :key => "minefold.#{Fold.env}.worlds", :public => false
  end
    
  def world_tiles
    Storage.provider.directories.create :key => "minefold.#{Fold.env}.world-tiles", :public => true
  end
end  