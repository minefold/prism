module Prism
  class PlayerDisconnectionEvent < Request
    attr_reader :redis
    
    process "players:disconnection_request", :username
    
    def run
      PrismRedis.new do |redis|
        @redis = redis
        
        op = redis.hget "players:playing", username
        op.callback do |world_id|
          debug "removing player:#{username} from world:#{world_id}"
          redis.hdel "players:playing", username
          op = redis.srem "worlds:#{world_id}:connected_players", username
          op.callback do
            op = redis.scard "worlds:#{world_id}:connected_players"
            op.callback do |player_count|
              stop_world world_id if player_count == 0
            end
          end
        end
      end
    end
    
    def stop_world world_id
      op = redis.hget "worlds:running", world_id
      op.callback do |message|
        if message
          world_data = JSON.parse message
          redis.lpush "worlds:requests:stop", {instance_id:world_data['instance_id'], world_id:world_id}.to_json
        else
          p world_id
          debug "world:#{world_id} not running. No stop required"
        end
      end
    end
  end
end