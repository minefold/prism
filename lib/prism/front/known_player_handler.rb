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
      PrismRedis.new do |redis|
        redis.rpc_json "players:connection_request", username do |connection|
          new_handler ConnectedPlayerHandler, username, connection["host"], connection["port"]
        end
      end
    end
    
  end
end