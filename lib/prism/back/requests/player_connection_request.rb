module Prism
  class PlayerConnectionRequest < Request
    process "players:connection_request", :username

    def log_tag; username; end
    
    def run
      debug "processing #{username}"

      EM.defer(proc { mongo_connect.collection('users').find_one(:username => /#{username}/i) }, proc { |user|
        if user
          if user['credits'] > 0
            recognised_player_connecting user
          else
            no_credit_player_connecting
          end
        else
          unrecognised_player_connecting
        end
      }) 
    end
    
    def recognised_player_connecting user
      user_id, world_id = "#{user['_id']}", "#{user['world_id']}"
      debug "found user:#{user_id} world:#{world_id}"
      
      redis.hset "usernames", username, user_id
      redis.lpush_hash "players:world_request", username:username, user_id:user_id, world_id:world_id, credits:user['credits']
    end
    
    def unrecognised_player_connecting
      info "unrecognised"
      redis.publish_json "players:connection_request:#{username}", rejected:'unrecognised_player'
    end
    
    def no_credit_player_connecting
      info "user:#{username} has no credit"
      redis.publish_json "players:connection_request:#{username}", rejected:'no_credit'
    end
  end
end
