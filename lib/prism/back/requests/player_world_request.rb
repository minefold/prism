module Prism
  class PlayerWorldRequest < Request
    attr_reader :redis
    
    process "players:world_request", :username, :user_id, :world_id
    
    def run
      redis_connect do |redis|
        @redis = redis
        
        resp = redis.hget "worlds:running", world_id
        resp.callback do |world_data|
          if world_data
            debug "world:#{world_id} is already running"
            world = JSON.parse world_data
            connect_player_to_world world['host'], world['port']
          else
            debug "world:#{world_id} is not running"
            get_world_started
          end
        end
      end
    end
    
    def connect_player_to_world host, port
      debug "connecting player:#{username}:#{user_id} to world:#{world_id}"
      @redis.hset "players:playing", username, world_id
      @redis.publish "players:connection_request:#{username}", {host:host, port:port}.to_json
    end
    
    def get_world_started
      debug "getting world:#{world_id} started"
      
      # any free workers?
      resp = redis.hgetall "workers:running"
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
          
          resp = redis.smembers "workers:sleeping"
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
      redis.rpc_json "worlds:requests:start", world_id, {
        instance_id:instance_id, 
        world_id:world_id, 
        min_heap_size:512, max_heap_size:2048 }.to_json do |world|
          connect_player_to_world world["host"], world["port"]
      end
    end
    
    def start_world_on_sleeping_worker instance_id
      debug "starting world:#{world_id} on sleeping worker:#{instance_id}"
      redis.rpc_json "workers:requests:start", instance_id, instance_id do |worker|
        debug "started sleeping worker:#{instance_id}"
        
        start_world_on_running_worker instance_id
      end
    end

    def start_world_on_new_worker
      request_id = `uuidgen`.strip
      debug "starting world:#{world_id} on new worker"
      redis.rpc_json "workers:requests:create", request_id, request_id do |worker|
        start_world_on_running_worker worker['instance_id']
      end
    end
  end
end