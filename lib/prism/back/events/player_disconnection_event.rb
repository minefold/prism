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
          record_session user_id
          redis.srem "worlds:#{world_id}:connected_players", user_id
        end
      end
    end

    def record_session user_id
      if started_at
        @mp_id, @mp_name = user_id, username
        seconds = ended_at - started_at
        mixpanel_track 'played', seconds: seconds, minutes: (seconds / 60.0).to_i, hours: (seconds / 60.0 / 60.0).to_i
      end
    end
  end
end