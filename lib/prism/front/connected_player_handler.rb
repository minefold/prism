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
      @client.server_unbound
    end
  end
  
  class ConnectedPlayerHandler < Handler
    include Messaging
    include MinecraftKeepalive
    
    attr_reader :username, :host, :port
    
    def log_tag; username; end
    
    def init username, host, port
      @server = EM.connect host, port, ServerConnection, self, connection.buffered_data
      @username, @host, @port = username, host, port
      @minecraft_session_started_at = Time.now
      @server_connected = true
      
      EM.add_timer(20) { disconnect_and_reconnect }
      
      debug "starting credit muncher"
      @credit_muncher = EventMachine::PeriodicTimer.new(60) do
        debug "recording minute played"
        redis.lpush_hash "players:minute_played", username:username, timestamp:Time.now.utc
      end
      
      listen_once("players:disconnect:#{username}") { exit }
      Resque.push 'high', class: 'PlayerConnectedJob', args: [username, Time.now.utc]
    end
    
    def exit
      @server.close_connection_after_writing
      if @credit_muncher
        debug "stopping credit muncher"
        @credit_muncher.cancel 
      end
      redis.lpush "players:disconnection_request", username
      StatsD.measure_timer @minecraft_session_started_at, "sessions.minecraft"
    end
    
    def receive_data data
      @server.send_data data if @server_connected
    end
    
    def disconnect_and_reconnect
      @server.close_connection_after_writing
      
      @server_connected = false

      start_keepalive username
      EM.add_timer(5) do
        puts "attempting reconnect"
        @server = EM.connect host, port, Prism::AuthenticatingMinecraftClient, self, username
      end
    end
    
    def connection_reestablished
      @server_connected = true
      stop_keepalive
    end
    
    def server_unbound
    end
    
    def client_unbound
      stop_keepalive
      
      debug "client disconnected"
    end
    
  end
end