require 'fog'

class Storage
  class << self; attr_accessor :provider; end
    
  def worlds
    Storage.provider.directories.create :key => WORLDS_BUCKET, :public => false
  end
end  