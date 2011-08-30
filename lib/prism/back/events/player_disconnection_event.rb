module Prism
  class PlayerDisconnectionEvent < Request
    process "players:disconnection_request", :username
    
    def run
        op = Prism.redis.hget "players:playing", username
        op.callback do |world_id|
          debug "removing player:#{username} from world:#{world_id}"
          Prism.redis.hdel "players:playing", username
          op = Prism.redis.srem "worlds:#{world_id}:connected_players", username
          op.callback do
            op = Prism.redis.scard "worlds:#{world_id}:connected_players"
            op.callback do |player_count|
              stop_world world_id if player_count == 0
            end
          end
        end

    end
    
    def stop_world world_id
      op = Prism.redis.hget "worlds:running", world_id
      op.callback do |message|
        if message
          world_data = JSON.parse message
          Prism.redis.lpush "worlds:requests:stop", {instance_id:world_data['instance_id'], world_id:world_id}.to_json
        else
          debug "world:#{world_id} not running. No stop required"
        end
      end
    end
  end
end