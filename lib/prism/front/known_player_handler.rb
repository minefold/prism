module Prism
  class KnownPlayerHandler < Handler
    include MinecraftKeepalive
    include Messaging
    
    attr_reader :username
    
    def log_tag; username; end
    
    def init username
      @username = username
      
      start_keepalive
      
      listen_once_json "players:connection_request:#{username}" do |connection|
        puts "  subscription callback"
        new_handler ConnectedPlayerHandler, username, connection["host"], connection["port"] if connection_active
      end
      
      request_player_connection
    end
    
    def exit
      stop_keepalive
      cancel_listener "players:connection_request:#{username}"
    end
        
    def request_player_connection
      redis.lpush "players:connection_request", username
    end
  end
end