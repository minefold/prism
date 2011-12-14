module Widget
  class WorldPlugin
    class << self
      attr_reader :plugins
      
      def inherited plugin
        @plugins ||= [] 
        @plugins << plugin 
      end
    end
    
    attr_reader :world_id
    
    def initialize world_id
      @world_id = world_id
    end
    
    def world_started; end
    def world_stopped; end
    def world_backed_up; end
    def players_listed usernames; end
    def player_connected username; end
    def player_disconnected username; end
  end
end