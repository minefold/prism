module Prism
  class ConnectedPlayerHandler < Handler
    include Messaging
    
    attr_reader :username, :host, :port, :user_id, :world_id
    
    def log_tag; username; end
    
    def init server, username, host, port, user_id, world_id
      @server = server
      @server.client = self
      
      @username, @host, @port, @user_id, @world_id = username, host, port
      @minecraft_session_started_at = Time.now
      
      # EM.add_timer(20) { disconnect_and_reconnect }
      
      debug "starting credit muncher"
      @credit_muncher = EventMachine::PeriodicTimer.new(60) do
        debug "recording minute played"
        redis.lpush_hash "players:minute_played", username:username, timestamp:Time.now.utc
        Resque.push 'high', class: 'MinutePlayedJob', args: [user_id, world_id, Time.now.utc]
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
      redis.lpush_hash "players:disconnection_request", username: username, 
                                                       remote_ip: remote_ip,
                                                      started_at: @minecraft_session_started_at.to_i, 
                                                        ended_at: Time.now.to_i
                                                        
      StatsD.measure_timer @minecraft_session_started_at, "sessions.minecraft"
      Resque.push 'high', class: 'PlayerDisconnectedJob', args: [username, Time.now.utc]
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