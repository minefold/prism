module Prism
  class PlayerMinutePlayedEvent < Request
    include ChatMessaging

    process "players:minute_played", :username, :timestamp

    def log_tag; username; end

    def run
      User.find_by_username(username) do |user|
        if user.nil?
          redis.publish "players:disconnect:#{username}", 'unrecognised_player'
        else
          info "played 1 minute [#{user.plan_status}]"

          unless user.plan_or_unlimited?
            user.update '$inc' => { 'credits' => -1 }
            credits_updated user.id, user.credits - 1
          end
        end
      end
    end

    def credits_updated user_id, credits_remaining
      messages = {
        15 => "15 minefold minutes left",
        5  =>  "5 minefold minutes left!"
      }.freeze

      EM.add_timer(60) { redis.publish "players:disconnect:#{username}", "no_credit" } if credits_remaining < 1

      if (message = messages[credits_remaining]) || credits_remaining < 1
        op = redis.hget "players:playing", username
        op.callback do |world_id|
          redis.hget_json "worlds:running", world_id do |world|
            if world
              instance_id = world['instance_id']
              send_world_player_message instance_id, world_id, username, message if message

              if credits_remaining < 1
                EM.add_timer(1)  { send_world_player_message instance_id, world_id, username, "Top up your account at minefold.com" }
                EM.add_timer(40) { send_world_player_message instance_id, world_id, username, "Thanks for playing!" }
              end
            end
          end
        end
      end

      EM.defer do
        UserMailer.send_reminder(user_id.to_s) if credits_remaining == 30
      end
    end
  end
end