require 'fileutils'
require 'environment'

module Jobs
  class RemoveWorld
    @queue = :world
    
    def self.perform world_name
      FileUtils.rm_rf "#{WORLDS}/#{world_name}"
    end
  end
end
