module Prism
  class KnownPlayerHandler < Handler
    include MinecraftKeepalive
    include Messaging
    include EM::P::Minecraft::Packets::Server

    include Logging

    attr_reader :username
    log_tags :username

    def friendly_kick_messages
      {
        'unknown_world' => %Q{Unknown server! Visit minefold.com},
        'no_credit' => %Q{Outta Time! For more time, go PRO at minefold.com},
        'banned' => %Q{You are banned from this server! Visit minefold.com},
        'not_whitelisted' => %Q{You are not white-listed on this server! Visit minefold.com},
        'no_instances_available' => %Q{Sorry! Minefold is under heavy load argh! Please try again in a few minutes},
        'prepare_world' => %Q{Sorry! There's a problem with your server. Please try again in a few minutes},
        '500' => %Q{Sorry! The gremlins messed something up, try connecting again while we spank them},

        'no_world' => %Q{No world! Create or join one at minefold.com},
        'unrecognised_player' => %Q{HEY! Check your username or sign up at minefold.com}
      }.freeze
    end


    def init username, target_host = nil
      @username, @target_host = username, target_host
      @connection_active = true

      start_keepalive username

      started_connection = Time.now

      listen_once_json "players:connection_request:#{username}" do |response|
        if @connection_active
          if response['host']
            connection_time_ms = (Time.now - started_connection) * 1000
            info "connection time:#{connection_time_ms}"
            StatsD.increment_and_measure_from started_connection, "players.connection_request.successful"

            host, port, player_id, world_id = response["host"], response["port"], response["player_id"], response["world_id"]

            server = EM.connect host,
                                port,
                                MinecraftProxy,
                                connection,
                                connection.buffered_data

            new_handler ConnectedPlayerHandler,
                        server,
                        username,
                        host,
                        port,
                        player_id,
                        world_id

          elsif response['rejected']
            connection.send_data server_packet(0xFF, :reason => friendly_kick_messages[response['rejected']])
            connection.close_connection_after_writing
            exit
            StatsD.increment_and_measure_from started_connection, "players.connection_request.failed"
            StatsD.increment_and_measure_from started_connection, "players.connection_request.failed.#{response['rejected']}"
          end
        end
      end

      listen_once("players:authenticate:#{username}") do |connection_hash|
        connection.send_data server_packet 0x02, connection_hash: connection_hash
        # key_request = Minecraft::MinecraftPacket.new 0xFD,
        #   :server_id => :string,
        #   :public_key => :byte_array,
        #   :verify_token => :byte_array
      end

      listen_once("players:disconnect:#{username}") do |message|
        connection.send_data server_packet 0xFF, :reason => message
        connection.close_connection_after_writing
        exit
      end

      redis.lpush_hash "players:connection_request", username:username, remote_ip:remote_ip, target_host:target_host
    end

    def exit
      stop_keepalive
      cancel_listener "players:connection_request:#{username}"
    end

    def client_unbound
      @connection_active = false
      # redis.lpush_hash "players:disconnection_request", username: username, remote_ip:remote_ip
      # p self.class.log_tags_cb
      debug "client disconnected"
    end
  end
end