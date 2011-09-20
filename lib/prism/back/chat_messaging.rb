module Prism
  module ChatMessaging
    def pluralize amount, singular
      "#{amount} #{singular}#{amount == 1 ? '' : 's'}"
    end

    def time_in_words minutes
      case
      when minutes < 60
        pluralize(minutes, "minute")
      else
        pluralize(minutes / 60, "hour")
      end
    end

    def send_delayed_message delay, message
      EM.add_timer(delay) { send_world_player_message world_id, username, message }
    end
    
    def send_world_player_message world_id, username, body
      redis.publish "worlds:#{world_id}:stdin", "tell #{username} #{body}"
    end
  end
end