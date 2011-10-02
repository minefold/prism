module Prism
  class PlayerDisconnectionEvent < Request
    include Messaging
    
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
      redis.hget_json "worlds:busy", world_id do |busy_world|
        if busy_world
          stop_busy_world world_id, busy_world
        else
          redis.hget_json "worlds:running", world_id do |world_data|
            if world_data
              instance_id = world_data['instance_id']
              redis.hset_hash "worlds:busy", world_id, state:'stopping'
              redis.lpush "workers:#{instance_id}:worlds:requests:stop", world_id
            else
              redis
              debug "world:#{world_id} not running. No stop required"
            end
          end
        end
      end
    end
    
    def stop_busy_world world_id, busy_world
      if busy_world['state'].include? 'starting'
        debug "world:#{world_id} is starting. Will request stop when started"
        redis.hset_hash "worlds:busy", world_id, state:'starting => stopping'
        listen_once "worlds:requests:start:#{world_id}" do
          debug "world:#{world_id} started. Requesting stop"
          stop_world world_id
        end
      else
        debug "world:#{world_id} is already stopping."
      end
      
    end
  end
end