module Prism
  module Back
    module PlayerConnection
      def reject_player username, reason, options = {}
        rejection = ({rejected: reason}).merge(options)

        if mp_id.nil?
          MinecraftPlayer.find_by_username_with_user(username) do |player|
            if player
              @mp_id, @mp_name, @remote_ip = player.distinct_id.to_s, player.username, player.last_remote_ip
            end
          end
        end

        mixpanel_track 'rejected', rejection
        redis.publish_json "players:connection_request:#{username}", rejection
      end
    end
  end
end