module Prism
  class PlayerMinutePlayedEvent < Request
    include ChatMessaging
    include Logging

    process "players:minute_played", :world_id, :player_id, :username, :session_started_at, :timestamp

    log_tags :world_id, :player_id, :username

    MESSAGES = {
      15 => "15 minefold minutes left",
      5  =>  "5 minefold minutes left!"
    }

    NEW_PLAYER_SESSION_MINUTES = 120 # new players can play for two hours without an account

    def run
      MinecraftPlayer.find_with_user(player_id) do |player|
        raise "unknown player:#{player_id}" unless player

        session_minutes = Time.parse(session_started_at).minutes_til(Time.now)
        info "played 1 minute [#{player.plan_status}] session:#{session_minutes} mins"

        player.update '$inc' => { 'minutes_played' => 1 }

        if player.limited_time?
          redis.hget_json "worlds:running", world_id do |world|
            @instance_id = world['instance_id']

            if player.user
              player.user.update '$inc' => { 'credits' => -1 }
            else
              send_onboarding_messages session_minutes, player
            end
            credits_updated player
          end
        end
      end
    end

    def credits_updated player
      EM.add_timer(60) { redis.publish "players:disconnect:#{player.id}", "no credit" } if player.credits <= 1

      if (message = MESSAGES[player.credits]) || player.credits <= 1
        send_delayed_message 0, message if message

        if player.credits < 1
          EM.add_timer(1)  { send_world_player_message instance_id, world_id, username, "Top up your account at minefold.com" }
          EM.add_timer(40) { send_world_player_message instance_id, world_id, username, "Thanks for playing!" }
        end
      end

      EM.defer do
        UserMailer.send_reminder(user_id.to_s) if player.credits == 30
      end
    end

    def send_onboarding_messages session_minutes, player
      if session_minutes == 1
        send_delayed_message 0, "/signup [address] to claim your account"

      # elsif session_minutes % 15 == 0
      #   send_delayed_message 0,
      #     "you can play for #{NEW_PLAYER_SESSION_MINUTES - session_minutes} more minutes"
      #   send_delayed_message 5,
      #     "get 10 hours free! Press t and type"
      #     "/signup me@email.com with your email address"
      else
        warn "no world running?"
      end
    end
  end
end