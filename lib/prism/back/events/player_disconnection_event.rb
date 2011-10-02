module Prism
  class PlayerDisconnectionEvent < Request
    process "players:disconnection_request", :username
    
    def run
      op = redis.hget "players:playing", username
      op.callback do |world_id|
        debug "removing player:#{username} from world:#{world_id}"
        redis.hdel "players:playing", username
        
        op = redis.hget "usernames", username
        op.callback do |user_id|
          op = redis.srem "worlds:#{world_id}:connected_players", user_id
          op.callback do
            op = redis.scard "worlds:#{world_id}:connected_players"
            op.callback do |player_count|
              debug "world:#{world_id} players:#{player_count}"
              stop_world world_id if player_count == 0
            end
          end
        end
      end
    end
    
    def stop_world world_id
      redis.hget_json "worlds:running", world_id do |world_data|
        if world_data
          instance_id = world_data['instance_id']
          redis.lpush "workers:#{instance_id}:worlds:requests:stop", world_id
        else
          debug "world:#{world_id} not running. No stop required"
        end
      end
    end
  end
end