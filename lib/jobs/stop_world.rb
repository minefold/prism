require 'worlds'

module Jobs
  class StopWorld
    @queue = :world
    
    def self.perform world_name
      world = Worlds.running.find {|w| w[:name] == world_name }
      `bundle exec god stop #{world[:god_name]}` if world

      puts "Waiting for world to stop"
      while Worlds.running.any? {|w| w[:name] == world_name } do
      end
      puts "Done"
    end
  end
end