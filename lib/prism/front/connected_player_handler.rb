module Prism
  class ConnectedPlayerHandler < Handler
    include EM::P::Minecraft::Packets::Server
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
          timestamp:Time.now.utc,
          session_started_at: @minecraft_session_started_at

        Resque.push 'high', class: 'MinutePlayedJob', args: [player_id, world_id, Time.now.utc]
      end

      listen_once("players:disconnect:#{username}") do |message|
        connection.send_data server_packet 0xFF, :reason => message
        connection.close_connection_after_writing
        exit
      end

      Resque.push 'high', class: 'PlayerConnectedJob', args: [player_id, world_id, Time.now.utc]
      redis.lpush_hash "player:connected",
        world_id: world_id,
        player_id: player_id,
        username: username,
        timestamp: Time.now.utc
    end

    def exit
      @server.close_connection_after_writing
      if @credit_muncher
        debug "stopping credit muncher"
        @credit_muncher.cancel
      end
      redis.hdel "players:playing", player_id

      StatsD.measure_timer @minecraft_session_started_at, "sessions.minecraft"
      redis.lpush_hash "player:disconnected",
        world_id: world_id,
        player_id: player_id,
        username: username,
        timestamp: Time.now.utc
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