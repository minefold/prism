module Prism
  class KnownPlayerHandler < Handler
    include MinecraftKeepalive
    include Messaging
    
    attr_reader :username
    
    def log_tag; username; end
    
    def init username
      @username = username
      
      start_keepalive
      
      started_connection = Time.now
      
      listen_once_json "players:connection_request:#{username}" do |response|
        if connection_active and response['host']
          connection_time_ms = (Time.now - started_connection) * 1000
          puts "connection time:#{connection_time_ms}"
          StatsD.increment_and_measure_from started_connection, "players.connection_request.successful"
          new_handler ConnectedPlayerHandler, username, response["host"], response["port"]
        else
          connection.close_connection_after_writing
          exit
          StatsD.increment_and_measure_from started_connection, "players.connection_request.failed"
          StatsD.increment_and_measure_from started_connection, "players.connection_request.failed.#{response['rejected']}"
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