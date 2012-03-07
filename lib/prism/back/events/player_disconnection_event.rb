module Prism
  class PlayerDisconnectionEvent < Request
    include Messaging
    include Mixpanel::EventTracker

    process "players:disconnection_request", :username, :remote_ip, :started_at, :ended_at

    def run
      op = redis.hget "players:playing", username
      op.callback do |world_id|
        debug "removing player:#{username} from world:#{world_id}"
        redis.hdel "players:playing", username

        op = redis.hget "usernames", username
        op.callback do |user_id|
          redis.srem "worlds:#{world_id}:connected_players", user_id
          redis.hdel "usernames", username
        end
      end
    end
  end
end