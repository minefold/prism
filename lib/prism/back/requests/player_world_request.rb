module Prism
  class PlayerWorldRequest < Request
    include Messaging
    include ChatMessaging

    process "players:world_request", :username, :user_id, :world_id, :credits

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
        listen_once_json "worlds:requests:start:#{world_id}" do |world|
          if world['failed']
            redis.publish_json "players:connection_request:#{username}", rejected:'500'
          else
            connect_player_to_world world['instance_id'], world['host'], world['port']
          end
        end
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
              start_options = WorldAllocator.new(universe).find_box_for_new_world world
              runpack_defaults = {
                         name: 'Minecraft',
                      version: 'HEAD', # HEAD, 1.1, bukkit-1.1-R3

                    data_file: world['world_data_file'] || "#{world_id}.tar.gz",
                          ops: op_usernames(world),

                         seed: world['seed'],
                   level_type: world['level_type'],
                  online_mode: world['online_mode'],
                   difficulty: world['difficulty'],
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
                # start_world_on_new_worker start_options
              end
            else
              redis.publish_json "players:connection_request:#{username}", rejected:'no_world'
            end
          })
      end
    end

    # def start_world_on_new_worker options
    #   request_id = `uuidgen`.strip
    #   debug "starting world:#{world_id} on new worker"
    #   redis.lpush_hash "workers:requests:create", options.merge( request_id:request_id )
    #   listen_once_json "workers:requests:create:#{request_id}" do |worker|
    #     debug "created new worker:#{worker['instance_id']}"
    # 
    #     start_world_on_started_worker options
    #   end
    # end

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

      redis.set_busy "worlds:busy", world_id, 'starting', expires_after: 120
      redis.lpush_hash "workers:#{instance_id}:worlds:requests:start", options

      listen_once_json "worlds:requests:start:#{world_id}" do |world|
        redis.hdel "worlds:busy", world_id

        if world['failed']
          redis.publish_json "players:connection_request:#{username}", rejected:'500'
        else
          connect_player_to_world world['instance_id'], world["host"], world["port"]
        end
      end
    end
    

    def connect_player_to_world instance_id, host, port
      puts "connecting to #{host}:#{port}"
      redis.publish_json "players:connection_request:#{username}", host:host, port:port, user_id:user_id, world_id:world_id

      op = redis.hget "usernames", username
      op.callback do |user_id|
        redis.sadd "worlds:#{world_id}:connected_players", user_id

        op = redis.scard "worlds:#{world_id}:connected_players"
        op.callback do |player_count|
          @instance_id = instance_id
          send_delayed_message 7, "Hi #{username} welcome to minefold!"
          send_delayed_message 13, "There #{player_count == 1 ? 'is' : 'are'} #{pluralize player_count, "player"} in this world"
        end
      end
    end
  end
end