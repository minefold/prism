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
      
      Prism::RedisUniverse.collect do |universe|
        instance_id = WorldAllocator.new(universe).find_box_for_new_world world_id
        if instance_id
          start_world_on_started_worker instance_id
        else
          start_world_on_new_worker 'm1.large' # TODO work out what instance type is best
        end
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