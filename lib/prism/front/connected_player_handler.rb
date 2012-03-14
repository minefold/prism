module Prism
  class ConnectedPlayerHandler < Handler
    include Messaging
    include Logging

    attr_reader :username, :host, :port, :player_id, :world_id

    log_tags :world_id, :username

    def init server, username, host, port, player_id, world_id
      @server = server
      @server.client = self

      @username, @host, @port, @player_id, @world_id = username, host, port, player_id, world_id
      @minecraft_session_started_at = Time.now

      # EM.add_timer(20) { disconnect_and_reconnect }

      redis.hset "players:playing", player_id, world_id
      debug "starting credit muncher"
      @credit_muncher = EventMachine::PeriodicTimer.new(60) do
        debug "recording minute played"
        redis.lpush_hash "players:minute_played",
          world_id: world_id,
          player_id: player_id,
          username:username, 
          timestamp:Time.now.utc
          
        Resque.push 'high', class: 'MinutePlayedJob', args: [player_id, world_id, Time.now.utc]
      end

      listen_once("players:disconnect:#{username}") { exit }

      Resque.push 'high', class: 'PlayerConnectedJob', args: [player_id, world_id, Time.now.utc]
    end

    def exit
      @server.close_connection_after_writing
      if @credit_muncher
        debug "stopping credit muncher"
        @credit_muncher.cancel
      end
      redis.hdel "players:playing", player_id
      
      # redis.lpush_hash "players:disconnection_request", player_id: player_id,
      #                                                  remote_ip: remote_ip,
      #                                                 started_at: @minecraft_session_started_at.to_i,
      #                                                   ended_at: Time.now.to_i

      StatsD.measure_timer @minecraft_session_started_at, "sessions.minecraft"
      Resque.push 'high', class: 'PlayerDisconnectedJob', args: [player_id, world_id, @minecraft_session_started_at, Time.now.utc]
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