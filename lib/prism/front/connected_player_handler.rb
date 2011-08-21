module Prism
  module ServerConnection
    include Debugger
    
    def initialize client, buffered_data
      @client, @buffered_data = client, buffered_data
    end
    
    def post_init
      send_data @buffered_data
    end
    
    def receive_data data
      @client.send_data data
    end

    def unbind
      debug "server connection closed"
      @client.close_connection_after_writing
    end
  end
  
  class ConnectedPlayerHandler < Handler
    attr_reader :username
    
    def init username, host, port
      @server = EM.connect host, port, ServerConnection, connection, connection.buffered_data
      @username = username
      
      @credit_muncher = EventMachine::PeriodicTimer.new(60) do
        PrismRedis.new{|redis| redis.lpush "players:minute_played", {username:username, timestamp:Time.now.utc}.to_json }
      end
    end
    
    def receive_data data
      @server.send_data data
    end
    
    def unbind
      debug "client connection closed"

      @credit_muncher.cancel if @credit_muncher      
      PrismRedis.new {|redis| redis.lpush "players:disconnection_request", username }
    end
  end
end