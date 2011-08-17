module Prism
  module ProxyConnection
    def post_init client_connection
      @client_connection = client_connection
      EM.enable_proxy self, @client_connection
    end

    def proxy_target_unbound
      close_connection
    end

    def unbind
      @client_connection.close_connection_after_writing
    end
  end
  
  class ConnectedPlayerHandler < Handler
    def init username, host, port
      EM.connect host, port, ProxyConnection, connection
    end
    
    def proxy_target_unbound
      @connection.close_connection
    end
  end
end