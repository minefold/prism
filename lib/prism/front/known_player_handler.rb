module Prism
  class KnownPlayerHandler < Handler
    include MinecraftKeepalive
    include Messaging
    include EM::P::Minecraft::Packets::Server

    attr_reader :username

    def friendly_kick_messages
      {
        'unrecognised_player' => %Q{HEY! Check your username or sign up at minefold.com},
        'no_credit' => %Q{Sorry you need to top up your account at http://minefold.com},
        'no_world' => %Q{You need to create or join a world! Visit http://minefold.com},
        'no_instances_available' => %Q{Sorry! Minefold is under heavy load argh! Please try again in a few minutes},
        '500' => %Q{Sorry! The gremlins messed something up, try connecting again while we spank them}
      }.freeze
    end

    def log_tag; username; end

    def init username
      @username = username
      @connection_active = true

      start_keepalive username

      started_connection = Time.now

      listen_once_json "players:connection_request:#{username}" do |response|
        if @connection_active
          if response['host']
            connection_time_ms = (Time.now - started_connection) * 1000
            info "connection time:#{connection_time_ms}"
            StatsD.increment_and_measure_from started_connection, "players.connection_request.successful"

            server = EM.connect response["host"], response["port"], MinecraftProxy, connection, connection.buffered_data
            new_handler ConnectedPlayerHandler, server, username, response["host"], response["port"], response["user_id"], response["world_id"]
          elsif response['rejected']
            connection.send_data server_packet(0xFF, :reason => friendly_kick_messages[response['rejected']])
            connection.close_connection_after_writing
            exit
            StatsD.increment_and_measure_from started_connection, "players.connection_request.failed"
            StatsD.increment_and_measure_from started_connection, "players.connection_request.failed.#{response['rejected']}"
          end
        end
      end

      redis.lpush_hash "players:connection_request", username:username, remote_ip:remote_ip
    end

    def exit
      stop_keepalive
      cancel_listener "players:connection_request:#{username}"
    end

    def client_unbound
      @connection_active = false
      redis.lpush_hash "players:disconnection_request", username: username, remote_ip:remote_ip
      debug "client disconnected"
    end
  end
end