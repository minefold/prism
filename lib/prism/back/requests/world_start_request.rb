module Prism
  class WorldStartRequest < Request
    include Messaging

    process "worlds:start_request", :world_id, :slots

    attr_reader :instance_id

    def reply options = {}
      puts "PUBLISH worlds:start_request:#{world_id}"
      redis.publish_json "worlds:start_request:#{world_id}", options
    end

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
          reply
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
              start_options = WorldAllocator.new(universe).start_options_for_new_world world, slots
              runpack_defaults = {
                         name: 'Minecraft',
                      version: 'HEAD', # HEAD, 1.1, bukkit-1.1-R3

                    data_file: world['world_data_file'],
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
                start_world_on_running_worker start_options
              else
                info "no instances available for world:#{world_id}"
                reply rejected:'no_instances_available'
              end
            else
              reply rejected:'not_found'
            end
          })
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
          reply rejected:'500'
        else
          reply instance_id: world['instance_id'],
                       host: world["host"],
                       port: world["port"]
        end
      end
    end
  end
end