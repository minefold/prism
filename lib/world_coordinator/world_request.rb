module WorldCoordinator
  class WorldRequest
    include Debugger
    
    attr_reader :user_id, :world_id
    def initialize user_id, world_id
      @user_id, @world_id = user_id, world_id
      
      find_world
    end
    
    def find_world
      debug "finding world for #{user_id}@#{world_id}"
      
    end
    
  end
end