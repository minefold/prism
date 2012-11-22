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
      @session_id = BSON::ObjectId.new.to_s

      # EM.add_timer(20) { disconnect_and_reconnect }

      redis.hset "players:playing", player_id, world_id
      debug "session:#{@session_id} started"

      Resque.push 'high', class: 'PlayerConnectedJob', args: [player_id, world_id, Time.now.utc]
      # redis.lpush_hash "player:connected",
      #   session_id: @session_id,
      #   world_id: world_id,
      #   player_id: player_id,
      #   username: username,
      #   timestamp: @minecraft_session_started_at.to_i
    end

    def exit
      @server.close_connection_after_writing
      redis.hdel "players:playing", player_id

      # redis.lpush_hash "player:disconnected",
      #   world_id: world_id,
      #   player_id: player_id,
      #   username: username,
      #   timestamp: Time.now.utc
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