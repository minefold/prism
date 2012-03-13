module Prism
  class PlayerConnectionRequest < Request
    include Mixpanel::EventTracker

    process "players:connection_request", :username, :target_host, :remote_ip

    info_tag { username }

    def run
      debug "processing #{username} #{target_host}"

      Player.upsert_by_username_with_user(username) do |player|

        # TODO: support other hosts besides fold.to
        if target_host =~ /^([\w-]+)\.([\w-]+)\.(localhost\.)?fold\.to\:?(\d+)?$/
          World.find_by_slug($2.downcase, $1.downcase) do |world|
            connect_to_world player, world
          end
        else
          # connecting to a different host, probably pluto, old sk00l
          connect_to_current_world player
        end
      end
    end

    # TODO: remove this method when we don't have "current worlds"
    def connect_to_current_world player
      User.find_by_username(username) do |user|
        player.user = user
        if player.user
          debug "found user:#{player.user.id} host:#{target_host}"
          if user.current_world_id
            World.find(player.user.current_world_id) {|world| connect_to_world player, world }
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

    def connect_to_world player, world
      if world
        debug "found world:#{world.id} #{world.name}"
        connect_to_known_world player, world
      else
        info "world:#{player.user.current_world_id} doesn't exist"
        redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
      end
    end

    def connect_to_known_world player, world
      if world.has_data_file?
        debug "world is valid"

        if player.has_credit?
          valid_player_connecting player, world
        else
          mixpanel_track 'bounced'
          no_credit_player_connecting
        end
      else
        info "world:#{world.id} data_file:#{world.data_file} does not exist"
        redis.publish_json "players:connection_request:#{username}",
          rejected:'500',
          details:"world data #{world.data_file} not found"
      end
    end

    def valid_player_connecting player, world
      player_id, world_id = player.id.to_s, world.id.to_s

      redis.lpush_hash "players:world_request",
       username: username,
       player_id: player_id,
        world_id: world_id,
        description: world.name

      player.update(last_connected_at: Time.now)
    end

    def unrecognised_player_connecting
      info "unrecognised"
      redis.publish_json "players:connection_request:#{username}", rejected:'unrecognised_player'
    end

    def no_credit_player_connecting
      info "user:#{username} has no credit"
      redis.publish_json "players:connection_request:#{username}", rejected:'no_credit'
    end
  end
end
