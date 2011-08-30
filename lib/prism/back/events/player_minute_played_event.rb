module Prism
  class PlayerMinutePlayedEvent < Request
    process "players:minute_played", :username, :timestamp
    
    def run
      op = Prism.redis.hget "usernames", username
      op.callback do |user_id|
        EM.defer(proc {
          mongo_connect.collection('users').find_and_modify({ 
              query: {"_id"  => BSON::ObjectId(user_id) },
              update:{
                '$push' => {'credit_history' => { 'created_at' => Time.now.utc, 'delta' => -1 } },
                '$inc'  => {'credits' => -1, 'minutes_played' => 1 }
              }
            })
        }, proc { |user|
          credits = user['credits'] - 1
          info "deducting 1 credit. #{credits} remaining. Played:#{user['minutes_played']} minutes"
        })
        
      end
    end
  end
end