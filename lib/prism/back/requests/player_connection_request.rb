module Prism
  class PlayerConnectionRequest < Request
    include Mixpanel::EventTracker

    process "players:connection_request", :username, :remote_ip

    def log_tag; username; end

    def run
      debug "processing #{username}"

      User.find_by_username username do |user|
        if user
          @mp_id, @mp_name = user.id.to_s, username
          if user.has_credit?
            recognised_player_connecting user
          else
            mixpanel_track 'bounced'
            no_credit_player_connecting
          end
        else
          mixpanel_track 'rejected'
          unrecognised_player_connecting
        end
      end
    end

    def recognised_player_connecting user
      user_id, world_id = user.id.to_s, user.current_world_id.to_s
      debug "found user:#{user_id} world:#{world_id}"

      if world_id && world_id.size > 0
        redis.hset "usernames", username, user_id
        redis.hset "players:playing", username, world_id
        redis.lpush_hash "players:world_request",
          username: username,
           user_id: user_id,
          world_id: world_id,
           credits: user.credits

        record_connection user_id, world_id
      else
        info "user:#{username} has no world"
        redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
      end
    end

    def unrecognised_player_connecting
      info "unrecognised"
      redis.publish_json "players:connection_request:#{username}", rejected:'unrecognised_player'
    end

    def no_credit_player_connecting
      info "user:#{username} has no credit"
      redis.publish_json "players:connection_request:#{username}", rejected:'no_credit'
    end

    def record_connection user_id, world_id
      EM.defer(proc {
          mongo_connect.collection('users').find_and_modify({
            query: {
              "_id"  => BSON::ObjectId(user_id)
            }, update: {
              '$set' => {'last_connected_at' => Time.now.utc }
            }
          })
        })
    end

  end
end
