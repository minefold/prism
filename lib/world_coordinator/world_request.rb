module WorldCoordinator
  class WorldRequest
    include Debugger
    
    attr_reader :username, :user_id, :world_id
    def initialize username, user_id, world_id
      @username, @user_id, @world_id = username, user_id, world_id
      
      find_world
    end
    
    def find_world
      debug "finding world for #{user_id}@#{world_id}"
      
      # find world
      
      redis = EM::Hiredis.connect
      redis.callback do
        redis.publish "players:requesting_connection_result:#{username}", { host:"0.0.0.0", port:"4000" }.to_json
      end
      
    end
    
  end
end