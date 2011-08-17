module Prism
  class KnownPlayerHandler < Handler
    attr_reader :username
    
    def init username
      @username = username
      
      @keepalive = EM::PeriodicTimer.new 15 do
        connection.send_data [0].pack('C')
      end
      
      request_player_connection
    end
    
    def request_player_connection
      redis = EM::Hiredis.connect
      redis.callback { redis.lpush "players:requesting_connection", username }
      
      subscriber = EM::Hiredis.connect
      subscriber.subscribe("players:requesting_connection_result:#{username}")
      subscriber.on(:message) do |channel, message|
        data = JSON.parse message
        new_handler ConnectedPlayerHandler, username, data["host"], data["port"]
      end
      
    end
    
  end
end