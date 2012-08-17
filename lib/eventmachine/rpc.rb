module EM
  class RPCConnection < Connection
    def initialize data, timeout, callback, one_packet
      @data, @timeout, @callback, @one_packet = data, timeout, callback, one_packet
      
      @responded = false
      @timed_out = false
      @received = nil
    end

    def post_init
      EM.add_timer(@timeout) do
        @timed_out = true
        close_connection
      end
      
      send_data @data
    end

    def receive_data data
      (@received ||= "") << data
      close_connection if @one_packet
    end
    
    def unbind
      if @callback
        @callback.call @timed_out ? nil : @received
      end
    end
  end

  # expects the server to hang up when it's finished sending data
  def self.rpc host, port, data, timeout, *a, &b
    cb = EM::Callback *a, &b if a.any? || b
    EM.connect host, port, RPCConnection, data, timeout, cb, false
    cb
  end
  
  # hangs up when any data is received
  def self.rpc_packet host, port, data, timeout, *a, &b
    cb = EM::Callback *a, &b if a.any? || b
    EM.connect host, port, RPCConnection, data, timeout, cb, true
    cb
  end
end