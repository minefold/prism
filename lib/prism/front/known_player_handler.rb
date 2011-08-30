module Prism
  class KnownPlayerHandler < Handler
    include MinecraftKeepalive
    attr_reader :username
    
    def log_tag; username; end
    
    def init username
      @username = username
      
      start_keepalive
      request_player_connection
    end
    
    def exit
      stop_keepalive
      @subscription.cancel_subscription "players:connection_request" if @subscription
    end
    
    def request_player_connection
      @subscription = Prism.redis.rpc_json "players:connection_request", username do |connection|
        new_handler ConnectedPlayerHandler, username, connection["host"], connection["port"] if connection_active
      end
    end
    
  end
end