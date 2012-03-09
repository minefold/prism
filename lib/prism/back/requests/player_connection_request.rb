module Prism
  class PlayerConnectionRequest < Request
    include Mixpanel::EventTracker

    process "players:connection_request", :username, :target_host, :remote_ip

    def log_tag; username; end

    def run
      debug "processing #{username}"

      User.find_by_slug(username.downcase.strip) do |user|
        if user
          debug "found user:#{user.id} #{user.email}  host:#{target_host}"
          @mp_id, @mp_name = user.mpid.to_s, user.email

          # eg. minebnb.whatupdave.fold.to
          if target_host =~ /^([\w-]+)\.([\w-]+)\.(localhost\.)?fold\.to\:?(\d+)?$/
            world_slug, creator_slug = $1.downcase, $2.downcase
            World.find_by_slug(creator_slug, world_slug) {|world| connect_to_world user, world }

          elsif user.current_world_id
            World.find(user.current_world_id) {|world| connect_to_world user, world }
          else
            info "user has no current_world"
            redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
          end
        else
          mixpanel_track 'rejected'
          unrecognised_player_connecting
        end
      end
    end

    def connect_to_world user, world
      if world
        debug "found world:#{world.id} #{user.slug}/#{world.slug}"

        if world.has_data_file?
          debug "world is valid"

          if user.has_credit?
            recognised_player_connecting user, world
          else
            mixpanel_track 'bounced'
            no_credit_player_connecting
          end
        else
          info "world:#{world.id} data_file:#{world.data_file} does not exist"
          redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
        end
      else
        info "world:#{user.current_world_id} doesn't exist"
        redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
      end
    end

    def recognised_player_connecting user, world
      user_id, world_id = user.id.to_s, world.id.to_s

      redis.hset "usernames", username, user_id
      redis.hset "players:playing", username, world_id
      redis.lpush_hash "players:world_request",
        username: username,
         user_id: user_id,
        world_id: world_id,
        description: "#{user.slug}/#{world.slug}"

      record_connection user_id, world_id
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
