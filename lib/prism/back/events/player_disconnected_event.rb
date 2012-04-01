module Prism
  class PlayerDisconnectedEvent < Request
    include ChatMessaging
    include Logging

    process "player:disconnected", :world_id, :player_id, :username, :timestamp

    log_tags :world_id, :player_id, :username

    def run
      MinecraftPlayer.find_with_user(player_id) do |player|
        raise "unknown player:#{player_id}" unless player

        debug "disconnected after #{player.last_connected_at.minutes_til(Time.now)} minutes"
      end
    end
  end
end