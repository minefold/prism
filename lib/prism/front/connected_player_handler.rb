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
      @client.close_connection_after_writing
    end
  end
  
  class ConnectedPlayerHandler < Handler
    def init username, host, port
      @server = EM.connect host, port, ServerConnection, connection, connection.buffered_data
    end
    
    def receive_data data
      @server.send_data data
    end
    
    def unbind
      debug "Process client disconnect"
    end
  end
end