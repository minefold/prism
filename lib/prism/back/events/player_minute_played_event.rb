module Prism
  class PlayerMinutePlayedEvent < Request
    include ChatMessaging
    include Logging

    process "players:minute_played", :world_id, :player_id, :username, :timestamp

    log_tags :world_id, :player_id, :username

    MESSAGES = {
      15 => "15 minefold minutes left",
      5  =>  "5 minefold minutes left!"
    }

    def run
      Player.find_with_user(player_id) do |player|
        raise "unknown player:#{player_id}" unless player

        info "played 1 minute [#{player.plan_status}]"

        player.update '$inc' => { 'minutes_played' => 1 }

        if player.limited_time?
          if player.user
            debug "user:#{user.id} #{user.plan_status}"
            player.user.update '$inc' => { 'credits' => -1 }
          else
            debug "player:#{id} has played for #{minutes_played} minutes"
          end
          credits_updated player
        end
      end
    end

    def credits_updated player
      EM.add_timer(60) { redis.publish "players:disconnect:#{player.id}", "no credit" } if player.credits_remaining <= 1

      if (message = MESSAGES[player.credits_remaining]) || player.credits_remaining <= 1
        redis.hget_json "worlds:running", world_id do |world|
          if world
            instance_id = world['instance_id']
            send_world_player_message instance_id, world_id, username, message if message

            if player.credits_remaining < 1
              EM.add_timer(1)  { send_world_player_message instance_id, world_id, username, "Top up your account at minefold.com" }
              EM.add_timer(40) { send_world_player_message instance_id, world_id, username, "Thanks for playing!" }
            end
          end
        end
      end

      EM.defer do
        UserMailer.send_reminder(user_id.to_s) if player.credits_remaining == 30
      end
    end
  end
end