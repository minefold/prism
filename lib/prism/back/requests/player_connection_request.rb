require 'eventmachine/periodic_timer_with_timeout'

module Prism
  class PlayerConnectionRequest < Request
    include Mixpanel::EventTracker
    include Messaging
    include Logging

    process "players:connection_request", :username, :target_host, :remote_ip

    log_tags :username

    def kick_player message
      redis.publish "players:disconnect:#{username}", message
    end

    def run
      debug "processing #{username} #{target_host}"

      MinecraftPlayer.upsert_by_username_with_user(username) do |player|
        debug "player:#{player.id} user:#{player.user.id if player.user}"
        @mp_id, @mp_name = player.distinct_id.to_s, player.username

        # TODO: support other hosts besides minefold.com
        if target_host =~ /^(\w+)\.(\w{1,16})\.minefold\.com\:?(\d+)?$/
          if $2 == 'verify'
            verify_player $1
          else
            World.find_by_name($2, $1) do |world|
              connect_unvalidated_player_to_unknown_world(player, world)
            end
          end
        else
          # connecting to a different host, probably pluto, old sk00l
          connect_to_current_world player
        end
      end
    end

    def verify_player token
      debug "verifying player with code:#{token}"
      User.find_by_verification_token(token) do |user|
        if user
          authenticate_player do |success|
            if success
              debug "verified"
              Resque.push 'high', class: 'UserVerifiedJob', args: [username, token]
              kick_player "Done! Your account is now verified"
            else
              debug "invalid player"
              kick_player "Bad account! You need a real minecraft.net account"
            end
          end
        else
          debug "invalid token"
          kick_player "Invalid verification code"
        end
      end
    end

    def authenticate_player *a, &b
      cb = EM::Callback *a, &b

      connection_hash = rand(36 ** 10).to_s(16)
      redis.publish "players:authenticate:#{username}", connection_hash
      timer = EM.periodic_with_timeout(0.5, 15)
      timer.timeout do
        cb.call false
      end
      timer.callback do |timer|
        url = "http://session.minecraft.net/game/checkserver.jsp?user=#{username}&serverId=#{connection_hash}"
        http = EventMachine::HttpRequest.new(url).get
        http.callback do
          if http.response.strip == 'YES'
            timer.cancel
            cb.call true
          end
        end
      end
      cb
    end

    def connect_unvalidated_player_to_unknown_world player, world
      if world
        if world.has_data_file? # TODO: Make this async!
          debug "world:#{world.id} found"
          connect_unvalidated_player_to_world player, world
        else
          error "world:#{world.id} data_file:#{world.world_data_file} does not exist"
          redis.publish_json "players:connection_request:#{username}",
            rejected:'500',
            details:"world data #{world.world_data_file} not found"
        end
      else
        debug "world not found"
        redis.publish_json "players:connection_request:#{username}", rejected:'unknown_world'
      end
    end

    def connect_unvalidated_player_to_world player, world
      if not player.has_credit?
        no_credit_player_connecting

      elsif world.banned?(player)
        debug "world:#{world.id} player:#{player.id} is banned"
        redis.publish_json "players:connection_request:#{username}", rejected:'banned'

      elsif not (world.whitelisted?(player) or world.op?(player))
        debug "world:#{world.id} player:#{player.id} is not whitelisted"
        redis.publish_json "players:connection_request:#{username}", rejected:'not_whitelisted'

      else
        debug "world:#{world.id} player:#{player.id} allowed to join"
        connect_player_to_world player, world
      end
    end

    def connect_player_to_world player, world
      player_id, world_id = player.id.to_s, world.id.to_s

      redis.lpush_hash "players:world_request",
       username: username,
       player_id: player_id,
        world_id: world_id,
        description: world.name
    end

    def unrecognised_player_connecting
      info "unrecognised"
      redis.publish_json "players:connection_request:#{username}", rejected:'unrecognised_player'
    end

    def no_credit_player_connecting
      mixpanel_track 'bounced'
      info "user:#{username} has no credit"
      redis.publish_json "players:connection_request:#{username}", rejected:'no_credit'
    end

    # TODO: remove this method when we don't have "current worlds"
    def connect_to_current_world player
      if player.user
        debug "found user:#{player.user.id} host:#{target_host}"
        if player.user.current_world_id
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

    # TODO: remove this old school path
    def connect_to_world player, world
      if world
        if world.has_data_file? # TODO: Make this async!
          debug "world:#{world.id} found"
          connect_unvalidated_player_to_current_world player, world
        else
          error "world:#{world.id} data_file:#{world.world_data_file} does not exist"
          redis.publish_json "players:connection_request:#{username}",
            rejected:'500',
            details:"world data #{world.world_data_file} not found"
        end
      else
        debug "world not found"
        redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
      end
    end

    def connect_unvalidated_player_to_current_world player, world
      if not player.has_credit?
        no_credit_player_connecting
      else
        connect_player_to_world player, world
      end
    end
  end
end
