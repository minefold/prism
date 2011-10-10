module Prism
  class PlayerWorldRequest < Request
    include Messaging
    include ChatMessaging
    
    process "players:world_request", :username, :user_id, :world_id, :credits
    
    attr_reader :instance_id
    
    PLAYER_RAM_SIZE = 128
    
    INSTANCE_PLAYER_CAPACITY = { 
      'm1.large'   => 50,
      'm2.xlarge'  => 130,
      'm2.2xlarge' => 260,
      'm2.4xlarge' => 530
    }.freeze
    
    INSTANCE_WORLD_CAPACITY = {
      'm1.large'   => 4,
      'm2.xlarge'  => 7,
      'm2.2xlarge' => 14,
      'm2.4xlarge' => 27
    }.freeze
    
    INSTANCE_PLAYER_BUFFER = 10 # needs to be space for 10 players to start a world
    
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
      if busy_world['state'].include? 'starting'
        debug "world:#{world_id} start already requested"
        listen_once_json "worlds:requests:start:#{world_id}" do |world|
          if world['failed']
            redis.publish_json "players:connection_request:#{username}", rejected:'500'
          else
            connect_player_to_world world['instance_id'], world['host'], world['port']
          end
        end
      else
        debug "world:#{world_id} is stopping. will request start when stopped"
        redis.hset_hash "worlds:busy", world_id, state:'stopping => starting'
        listen_once "worlds:requests:stop:#{world_id}" do
          debug "world:#{world_id} stopped. Requesting restart"
          start_world
        end
      end
    end
    
    def start_world
      debug "getting world:#{world_id} started"
      
      # any free boxes?
      op = redis.hgetall_json("workers:running")
      op.callback do |boxes|
        EM::Iterator.new(boxes).inject({}, proc{ |hash, (instance_id, box), iter|
            instance_type = box['instance_type']
            player_capacity = INSTANCE_PLAYER_CAPACITY[instance_type]
            world_capacity  = INSTANCE_WORLD_CAPACITY[instance_type]
            
            op = redis.smembers "workers:#{instance_id}:worlds" 
            op.callback do |worlds|
              world_count = worlds.size
              world_sets = worlds.map {|world_id| "worlds:#{world_id}:connected_players"}
              if world_sets.any?
                
                op = redis.sunion world_sets
                op.callback do |connected_players|
                  puts "box:#{instance_id} world_count:#{world_count} player_count:#{connected_players.size} player_cap:#{player_capacity} world_cap:#{world_capacity} (#{instance_type})"
                  
                  if (player_capacity - connected_players.size > INSTANCE_PLAYER_BUFFER) &&
                     (world_capacity - world_count > 0)
                    hash[instance_id] = box
                  end
                  iter.return hash
                end
              else
                puts "box:#{instance_id} world_count:0 player_count:0 player_cap:#{player_capacity} world_cap:#{world_capacity} (#{instance_type})"
                hash[instance_id] = box
                iter.return hash
              end
            end
          }, proc { |workers_with_capacity|
            if workers_with_capacity.any?
              sorted_workers = workers_with_capacity.sort_by do |instance_id, w| 
                Time.now - Time.parse(w['started_at'])
              end
            
              instance_id = sorted_workers.first[0]
            
              start_world_on_started_worker instance_id
            else
              start_world_on_new_worker 'm1.large' # TODO work out what instance type is best
            end
          })
      end
    end
    
    def start_world_on_running_worker instance_id
      debug "starting world:#{world_id} on running worker:#{instance_id}"
      
      redis.hset_hash "worlds:busy", world_id, state:'starting'
      
      redis.lpush "workers:#{instance_id}:worlds:requests:start", {
        instance_id:instance_id, 
        world_id:world_id, 
        min_heap_size:512, max_heap_size:(4 * 1024) 
      }.to_json 
      
      listen_once_json "worlds:requests:start:#{world_id}" do |world|
        if world['failed']
          redis.hdel "worlds:busy", world_id
          redis.publish_json "players:connection_request:#{username}", rejected:'500'
        else
          connect_player_to_world world['instance_id'], world["host"], world["port"]
        end
      end
    end
    
    def start_world_on_new_worker instance_type
      request_id = `uuidgen`.strip
      debug "starting world:#{world_id} on new worker"
      redis.lpush_hash "workers:requests:create", request_id:request_id, instance_type:instance_type
      listen_once_json "workers:requests:create:#{request_id}" do |worker|
        debug "created new worker:#{worker['instance_id']}"
        
        start_world_on_started_worker worker['instance_id']
      end
    end
    
    def start_world_on_started_worker instance_id
      # player still around?
      op = redis.hexists "players:playing", username
      op.callback do |player_connected|
        if player_connected
          start_world_on_running_worker instance_id 
        else
          debug "player:#{username} has disconnected wont start world:#{world_id} on worker:#{instance_id}"
        end
      end
    end
    
    def connect_player_to_world instance_id, host, port
      puts "connecting to #{host}:#{port}"
      redis.publish_json "players:connection_request:#{username}", host:host, port:port
      
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