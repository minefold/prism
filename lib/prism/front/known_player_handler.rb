module Prism
  class KnownPlayerHandler < Handler
    include MinecraftKeepalive
    
    attr_reader :username
    
    def init username
      @username = username
      
      start_keepalive
      request_player_connection
    end
    
    def exit
      stop_keepalive
    end
    
    def request_player_connection
      redis = EM::Hiredis.connect
      redis.callback { redis.lpush "players:connection_request", username }
      
      subscriber = EM::Hiredis.connect
      debug "subscribing to players:connection_request:#{username}"
      subscriber.subscribe("players:connection_request:#{username}")
      subscriber.on(:message) do |channel, message|
        data = JSON.parse message
        new_handler ConnectedPlayerHandler, username, data["host"], data["port"]
      end
      
    end
    
  end
end