module Prism
  class PlayerWorldRequest < Request
    include Messaging
    include ChatMessaging
    include Logging

    process "players:world_request", :username, :player_id, :world_id, :description

    log_tags :player_id, :world_id

    attr_reader :instance_id

    def run
      redis.hget_json "worlds:busy", world_id do |busy_world|
        if busy_world
          start_busy_world busy_world
        else
          get_world_started
        end
      end
    end

    def get_world_started
      redis.hget_json "worlds:running", world_id do |world|
        if world
          debug "world is already running"
          connect_player_to_world world['instance_id'], world['host'], world['port']
        else
          debug "world not running"
          start_world
        end
      end
    end

    def start_busy_world busy_world
      state = busy_world['state']
      case
      when state.include?('starting')
        debug "world start already requested"
        respond_to_world_start_event

      when state.include?('stopping')
        debug "world is stopping. will request start when stopped"
        redis.set_busy "worlds:busy", world_id, 'stopping => starting', expires_after: 120
        listen_once "worlds:requests:stop:#{world_id}" do
          debug "world:#{world_id} stopped. Requesting restart"
          start_world
        end
      else
        get_world_started
      end
    end

    def op_ids world
      [world['creator_id']] +
       world['memberships'].
         select {|m| m['role'] == 'op' }.
            map {|m| m['user_id']}
    end

    def op_usernames world
      MinefoldDb.connection['users'].
        find('_id' => { '$in' => op_ids(world) }).
        map {|u| u['username']}
    end

    def start_world
      debug "getting world:#{world_id} started"

      Prism::RedisUniverse.collect do |universe|
        World.find(world_id) do |world|
          if world
            start_options = WorldAllocator.new(universe).find_box_for_new_world world.doc
            if start_options and start_options[:instance_id]
              opped_player_ids = Array(world.opped_player_ids)
              whitelisted_player_ids = Array(world.whitelisted_player_ids)
              banned_player_ids = Array(world.banned_player_ids)

              world_player_ids = opped_player_ids | whitelisted_player_ids | banned_player_ids

              MinecraftPlayer.find_all(deleted_at: nil, _id: {'$in' => world_player_ids}) do |world_players|
                opped_players = world_players.select{|p| opped_player_ids.include?(p.id)}
                whitelisted_players = world_players.select{|p| whitelisted_player_ids.include?(p.id)}
                banned_players = world_players.select{|p| banned_player_ids.include?(p.id)}

                runpack_defaults = {
                           name: 'Minecraft',
                        version: 'HEAD', # HEAD, 1.1, bukkit-1.1-R3

                      data_file: world.world_data_file,
                            ops: (opped_players.map(&:username) | World::DEFAULT_OPS).compact,
                    whitelisted: whitelisted_players.map(&:username).compact,
                         banned: banned_players.map(&:username).compact,

                        plugins: []
                }
                world_settings = %w(seed level_type online_mode difficulty game_mode pvp spawn_animals spawn_monsters)
                runpack_defaults.merge!(world_settings.each_with_object({}){|setting, h| h[setting] = world.doc[setting] })

                start_options.merge! world_id: world_id, runpack: runpack_defaults.merge(world.runpack || {})

                debug "start options: #{start_options}"

                start_world_on_started_worker start_options
              else
                info "no instances available"
                redis.publish_json "players:connection_request:#{username}", rejected:'no_instances_available'
              end
            end
          else
            redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
          end
        end
      end
    end

    def start_world_on_started_worker options
      # player still around?
      op = redis.hexists "players:playing", username
      op.callback do |player_connected|
        if player_connected
          start_world_on_running_worker options
        else
          debug "player:#{username} has disconnected wont start world:#{world_id} on worker:#{instance_id}"
        end
      end
    end

    def start_world_on_running_worker options
      instance_id = options[:instance_id]
      debug "starting world:#{world_id} on worker:#{instance_id} heap:#{options[:heap_size]}"

      redis.set_busy "worlds:busy", world_id, 'starting', expires_after: 600
      redis.lpush_hash "workers:#{instance_id}:worlds:requests:start", options

      respond_to_world_start_event
    end

    def respond_to_world_start_event
      listen_once_json "worlds:requests:start:#{world_id}" do |world|
        redis.hdel "worlds:busy", world_id

        if world['failed']
          Exceptional.rescue { raise "World start failed: #{world['failed']}" }

          redis.publish_json "players:connection_request:#{username}", rejected:'500'
        else
          connect_player_to_world world['instance_id'], world["host"], world["port"]
        end
      end
    end


    def connect_player_to_world instance_id, host, port
      puts "connecting to #{host}:#{port}"
      redis.publish_json "players:connection_request:#{username}", host:host, port:port, player_id:player_id, world_id:world_id
    end
  end
end