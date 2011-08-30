module Prism
  class PlayerConnectionRequest < Request
    process "players:connection_request", :username

    def log_tag; username; end
    
    def run
      debug "processing #{username}"

      EM.defer(proc { mongo_connect.collection('users').find_one(:username => /#{username}/i) }, proc { |user|
        if user
          recognised_player_connecting user
        else
          unrecognised_player_connecting
        end
      }) 
    end
    
    def recognised_player_connecting user
      debug "found user:#{user['_id']} world:#{user['world_id']}"
      
      Prism.redis.hset "usernames", username, user['_id'].to_s
      Prism.redis.lpush "players:world_request", { 'username' => username, 'user_id' => user['_id'].to_s, 'world_id' => user['world_id'].to_s }.to_json
    end
    
    def unrecognised_player_connecting
      error "unrecognised"
      Prism.redis.publish "players:connection_request:#{username}", nil
    end
  end
end