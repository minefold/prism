module Prism
  class KnownPlayerHandler < Handler
    include MinecraftKeepalive
    include Messaging
    
    attr_reader :username
    
    def log_tag; username; end
    
    def init username
      @username = username
      
      start_keepalive
      
      listen_once_json "players:connection_request:#{username}" do |response|
        if connection_active and response['host']
          new_handler ConnectedPlayerHandler, username, response["host"], response["port"]
        else
          connection.close_connection_after_writing
          exit
        end
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