require 'targz'
require 'tmpdir'

class MapError < StandardError; end

module Job
  class MapWorld
    include Resque::Plugins::UniqueJob
    @queue = :worlds_to_map

    def self.perform world_id
    end
  end
end