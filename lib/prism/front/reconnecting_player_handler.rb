module Prism
  class ReconnectingPlayerHandler < Handler
    include Messaging
    include MinecraftKeepalive

    attr_reader :username, :host, :port

    def log_tag; username; end

    def init server, username, host, port
      start_keepalive username
      info "attempting reconnect"
      @server = EM.connect host, port, Prism::AuthenticatingMinecraftProxy, self, username
    end

    def connection_reestablished
      stop_keepalive
      new_handler ConnectedPlayerHandler, @server, username, host, port
    end

    def server_unbound
      stop_keepalive

      debug 'server disconnected during authentication'
      connection.close_connection
    end

    def client_unbound
      stop_keepalive
      debug 'client disconnected during authentication'
      @server.close_connection
    end

  end
end