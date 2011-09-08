module Prism
  class PlayerWorldRequest < Request
    include Messaging
    
    process "players:world_request", :username, :user_id, :world_id
    
    def run
      Prism.redis.hget_json "worlds:busy", world_id do |busy_world|
        if busy_world
          start_busy_world busy_world
        else
          get_world_started
        end
      end
    end
    
    def get_world_started
      Prism.redis.hget_json "worlds:running", world_id do |world|
        if world
          debug "world:#{world_id} is already running"
          connect_player_to_world world['host'], world['port']
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
          connect_player_to_world world['host'], world['port']
        end
      else
        debug "world:#{world_id} is stopping. will request start when stopped"
        Prism.redis.hset_hash "worlds:busy", world_id, state:'stopping => starting'
        listen_once "worlds:requests:stop:#{world_id}" do
          debug "world:#{world_id} stopped. Requesting restart"
          start_world
        end
      end
    end
    
    def start_world
      debug "getting world:#{world_id} started"
      
      # any free workers?
      resp = Prism.redis.hgetall "workers:running"
      resp.callback do |workers|
        if workers.any?
          # [ "i-5678", {}, "i-6352", {}] etc
          # get worker with most minutes remaining
          worker = workers.each_slice(2).map{|w| JSON.parse w[1] }.sort_by do |w| 
            uptime_minutes = (Time.now - Time.parse(w['started_at'])).to_i / 60
            uptime_minutes % 60
          end.first
          
          start_world_on_running_worker worker['instance_id']
        else
          
          resp = Prism.redis.smembers "workers:sleeping"
          resp.callback do |sleeping_workers|
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
      Prism.redis.lpush "worlds:requests:start", {
        instance_id:instance_id, 
        world_id:world_id, 
        min_heap_size:512, max_heap_size:2048 
      }.to_json 
      
      listen_once_json "worlds:requests:start:#{world_id}" do |world|
          connect_player_to_world world["host"], world["port"]
      end
    end
    
    def start_world_on_sleeping_worker instance_id
      debug "starting world:#{world_id} on sleeping worker:#{instance_id}"
      
      Prism.redis.lpush "workers:requests:start", instance_id
      listen_once "workers:requests:start:#{instance_id}" do
        debug "started sleeping worker:#{instance_id}"
        
        start_world_on_running_worker instance_id
      end
    end

    def start_world_on_new_worker
      request_id = `uuidgen`.strip
      debug "starting world:#{world_id} on new worker"
      Prism.redis.lpush "workers:requests:create", request_id
      listen_once_json "workers:requests:create:#{request_id}" do |worker|
        start_world_on_running_worker worker['instance_id']
      end
    end
    
    def connect_player_to_world host, port
      puts "connecting to #{host}:#{port}"
      Prism.redis.hset "players:playing", username, world_id
      Prism.redis.publish_json "players:connection_request:#{username}", host:host, port:port
    end
    
  end
end