module Prism
  class PlayerConnectionRequest < Request
    include Mixpanel::EventTracker

    process "players:connection_request", :username, :target_host, :remote_ip

    def log_tag; username; end

    def run
      debug "processing #{username} #{target_host}"

      Player.upsert_by_username(username) do |player|
        # TODO: support other hosts besides fold.to
        if target_host =~ /^([\w-]+)\.([\w-]+)\.(localhost\.)?fold\.to\:?(\d+)?$/
          connect_to_target $1.downcase, $2.downcase
        else
          # connecting to pluto, old sk00l
          connect_to_current_world player
        end
      end
    end

    def connect_to_target world_slug, creator_slug
      World.find_by_slug(creator_slug, world_slug) do |world|
        connect_to_world player, world
      end
    end

    def connect_to_current_world player
      # TODO: don't load user after we migrate
      User.find_by_username(username) do |user|
        if user
          debug "found user:#{user.id} host:#{target_host}"
          if user.current_world_id
            World.find(user.current_world_id) {|world| connect_to_world player, world }
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
    
    def has_credit? player, user
      if user
        debug "user:#{user.id} #{user.plan_status}"
        user.has_credit?
      else
        debug "player:#{player.id} has played for #{player.minutes_played} minutes"
        player.has_credit?
      end
    end
    
    def connect_to_world player, world
      if world
        debug "found world:#{world.id} #{world.name}"
        if player.user_id
          User.find(player.user_id) do |user|
            if user
              connect_user_to_world player, user, world
            else
              info "no user found for player.user_id:#{player.user_id}"
              redis.publish_json "players:connection_request:#{username}", rejected:'500'
            end
          end
        else
          info "player:#{player.id} has no user"
          recognised_player_connecting player, world
        end
      else
        info "world:#{user.current_world_id} doesn't exist"
        redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
      end
    end
    
    def connect_user_to_world player, user, world
      if world.has_data_file?
        debug "world is valid"

        if has_credit?(player, user)
          recognised_player_connecting player, world
        else
          mixpanel_track 'bounced'
          no_credit_player_connecting
        end
      else
        info "world:#{world.id} data_file:#{world.data_file} does not exist"
        redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
      end
    end

    def recognised_player_connecting player, world
      player_id, world_id = player.id.to_s, world.id.to_s

      redis.hset "players:playing", player_id, world_id
      redis.lpush_hash "players:world_request",
        username: username,
       player_id: player_id,
        world_id: world_id,
        description: world.name

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
