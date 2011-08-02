require 'fog'

class Storage
  class << self; attr_accessor :provider; end
    
  def worlds
    Storage.provider.directories.create :key => "minefold.#{Fold.env}.worlds", :public => false
  end
  
  def worlds_to_import
    Storage.provider.directories.create :key => "minefold.#{Fold.env}.worlds_to_import", :public => false
  end
  
  def world_tiles
    Storage.provider.directories.create :key => "minefold.#{Fold.env}.world-tiles", :public => false
  end
end  