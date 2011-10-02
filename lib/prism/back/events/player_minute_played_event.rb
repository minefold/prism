module Prism
  class PlayerMinutePlayedEvent < Request
    include ChatMessaging

    process "players:minute_played", :username, :timestamp

    def run
      op = redis.hget "usernames", username
      op.callback do |user_id|
        EM.defer(proc {
          mongo_connect.collection('users').find_and_modify({
              query: {"_id"  => BSON::ObjectId(user_id) },
              update:{
                '$push' => {'credit_events' => { 'created_at' => Time.now.utc, 'delta' => -1 } },
                '$inc'  => {'credits' => -1, 'minutes_played' => 1 }
              }
            })
        }, proc { |user|
          credits = user['credits'] - 1
          info "deducting 1 credit. #{credits} remaining. Played:#{user['minutes_played']} minutes"
          credits_updated user_id, credits
        })

      end
    end

    def credits_updated user_id, credits_remaining
      messages = {
        30 => "30 minefold minutes left",
        10 => "10 minefold minutes left",
        5  =>  "5 minefold minutes left!",
        1  =>  "1 minefold minutes left!"
      }.freeze

      if message = messages[credits_remaining]
        op = redis.hget "players:playing", username
        op.callback do |world_id|
          op = redis.hget_hash "worlds:running", world_id
          op.callback do |world|
            send_world_player_message world['instance_id'], world_id, username, message
            if credits_remaining == 1
              EM.add_timer(1)  { send_world_player_message world['instance_id'], world_id, username, "Top up your account at minefold.com" }
              EM.add_timer(40) { send_world_player_message world['instance_id'], world_id, username, "Thanks for playing!" }
              EM.add_timer(60) { redis.publish "players:disconnect:#{username}", "no credit" }
            end
          end
        end
      end

      EM.defer do
        UserMailer.send_reminder(user_id.to_s) } if credits_remaining == 30
      end
    end
  end
end