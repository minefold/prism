module Prism
  class ConnectedPlayerHandler < Handler
    include Messaging
    
    attr_reader :username, :host, :port
    
    def log_tag; username; end
    
    def init server, username, host, port
      @server = server
      @server.client = self
      
      @username, @host, @port = username, host, port
      @minecraft_session_started_at = Time.now
      
      # EM.add_timer(20) { disconnect_and_reconnect }
      
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
      @server.send_data data
    end
    
    def server_unbound
      debug "server disconnected while connected"
      connection.close_connection
    end
    
    def client_unbound
      debug "client disconnected while connected"
      @server.close_connection
    end
    
  end
end