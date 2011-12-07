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
  end
end