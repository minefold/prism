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
      end
    end
  end
end