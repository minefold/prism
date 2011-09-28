module Prism
  class PlayerWorldRequest < Request
    include Messaging
    include ChatMessaging
    
    process "players:world_request", :username, :user_id, :world_id, :credits
    
    attr_reader :instance_id
    
    def run
      puts "world request"
      redis.hget_json "worlds:busy", world_id do |busy_world|
        puts "world reply"
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
          connect_player_to_world world['instance_id'], world['host'], world['port']
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
      
      # any free workers?
      redis.hgetall_json("workers:running") do |workers|
        if workers.any?
          # get worker with most minutes remaining
          # TODO make sure to create new worker if worker is at capacity
          sorted_workers = workers.sort_by do |instance_id, w| 
            uptime_minutes = (Time.now - Time.parse(w['started_at'])).to_i / 60
            uptime_minutes % 60
          end
          
          instance_id = sorted_workers.first[0]
          
          start_world_on_running_worker instance_id
        else
          
          op = redis.smembers "workers:sleeping"
          op.callback do |sleeping_workers|
            debug "workers:sleeping #{sleeping_workers.size}"
            
            if sleeping_workers.any?
              start_world_on_sleeping_worker sleeping_workers.first
            else
              start_world_on_new_worker
            end
          end
        end
      end
    end
    
    def start_world_on_running_worker instance_id
      debug "starting world:#{world_id} on running worker:#{instance_id}"
      redis.lpush "workers:#{instance_id}:worlds:requests:start", {
        instance_id:instance_id, 
        world_id:world_id, 
        min_heap_size:512, max_heap_size:2048 
      }.to_json 
      
      listen_once_json "worlds:requests:start:#{world_id}" do |world|
        if world['failed']
          run # try again
        else
          connect_player_to_world world['instance_id'], world["host"], world["port"]
        end
      end
    end
    
    def start_world_on_sleeping_worker instance_id
      debug "starting world:#{world_id} on sleeping worker:#{instance_id}"
      
      redis.lpush "workers:requests:start", instance_id
      listen_once "workers:requests:start:#{instance_id}" do
        debug "started sleeping worker:#{instance_id}"
        
        start_world_on_started_worker instance_id
      end
    end

    def start_world_on_new_worker
      request_id = `uuidgen`.strip
      debug "starting world:#{world_id} on new worker"
      redis.lpush "workers:requests:create", request_id
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
          send_delayed_message 13, "You have #{time_in_words credits} of play remaining"
          send_delayed_message 17, "There #{player_count == 1 ? 'is' : 'are'} #{pluralize player_count, "player"} in this world"
        end
      end
    end
  end
end