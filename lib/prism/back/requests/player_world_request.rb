module Prism
  class PlayerWorldRequest < Request
    include Messaging
    include ChatMessaging
    include Logging

    process "players:world_request", :username, :player_id, :world_id, :description

    log_tags :player_id, :world_id

    attr_reader :instance_id
    
    def run
      redis.hget_json "worlds:running", world_id do |world|
        if world
          connect_player_to_world world['instance_id'], world['host'], world['port']
        else
          start_world
        end
      end
    end

    def start_world
      debug "world:#{world_id} is not running"
      redis.lpush_hash "worlds:requests:start", world_id: world_id
      listen_once_json "worlds:requests:start:#{world_id}" do |world|
        if world
          connect_player_to_world world['instance_id'], world['host'], world['port']
        else
          redis.publish_json "players:connection_request:#{username}", rejected: world['failed']
        end
      end
    end


    def connect_player_to_world instance_id, host, port
      info "connecting to #{host}:#{port}"
      redis.publish_json "players:connection_request:#{username}", host:host, port:port, player_id:player_id, world_id:world_id
    end
  end
end