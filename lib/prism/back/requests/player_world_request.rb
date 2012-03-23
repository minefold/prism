module Prism
  class PlayerWorldRequest < Request
    include Messaging
    include ChatMessaging

    process "players:world_request", :username, :user_id, :world_id, :description

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
          debug "world:#{world_id} is already running"
          connect_player_to_world world['instance_id'], world['host'], world['port']
        else
          debug "world:#{world_id} is not running"
          start_world
        end
      end
    end


    def start_busy_world busy_world
      state = busy_world['state']
      case
      when state.include?('starting')
        debug "world:#{world_id} start already requested"
        respond_to_world_start_event

      when state.include?('stopping')
        debug "world:#{world_id} is stopping. will request start when stopped"
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
        EM.defer(proc {
            mongo_connect['worlds'].find_one({"_id"  => BSON::ObjectId(world_id) })
          }, proc { |world|
            if world
              mongo_connect.collection('users').find_one({"_id"  => BSON::ObjectId(user_id) })
              start_options = WorldAllocator.new(universe).start_options_for_new_world world, (world['allocation_slots'] || 1)
              runpack_defaults = {
                         name: 'Minecraft',
                      version: 'HEAD', # HEAD, 1.1, bukkit-1.1-R3

                    data_file: world['world_data_file'],
                          ops: op_usernames(world),

                         seed: world['seed'],
                   level_type: world['level_type'],
                  online_mode: world['online_mode'],
                   difficulty: world['difficulty_level'],
                    game_mode: world['game_mode'],
                          pvp: world['pvp'],
                spawn_animals: world['spawn_animals'],
               spawn_monsters: world['spawn_monsters'],

                      plugins: []
              }

              start_options.merge! world_id: world_id, runpack: runpack_defaults.merge(world['runpack'] || {})


              if start_options[:instance_id]
                start_world_on_started_worker start_options
              else
                info "no instances available for user:#{username} world:#{world_id}"
                redis.publish_json "players:connection_request:#{username}", rejected:'no_instances_available'
              end
            else
              redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
            end
          })
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
      redis.publish_json "players:connection_request:#{username}", host:host, port:port, user_id:user_id, world_id:world_id

      op = redis.hgetall "players:playing"
      op.callback do |players|
        world_players = players.each_with_object({}) do |(username, world_id), h|
          h[world_id] ||= []
          h[world_id] += [username]
        end

        @instance_id = instance_id
        send_delayed_message 4, "Hi #{username} welcome to minefold.com!"
        send_delayed_message 7, "You're playing in #{description}"
        if world_players[world_id]
          player_count = world_players[world_id].size
          send_delayed_message 10, player_count == 1 ?
            "It's just you, invite some friends!" :
            "There #{player_count == 2 ? 'is' : 'are'} #{pluralize (player_count - 1), "other player"} in this world"
        end
      end
    end
  end
end