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
      EM.add_timer(delay) { send_world_player_message instance_id, world_id, username, message }
    end

    def send_world_player_message instance_id, world_id, username, body
      world_stdin = "workers:#{instance_id}:worlds:#{world_id}:stdin"
      redis.publish world_stdin, "tell #{username} #{body}"
    end

    def send_world_message instance_id, world_id, message
      world_stdin = "workers:#{instance_id}:worlds:#{world_id}:stdin"
      redis.publish world_stdin, "say #{message}"
    end
  end
end