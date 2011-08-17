module Prism
  class FakeConnection
    include Prism::Client
  
    attr_reader :connection_open

    def initialize
      @connection_open = true
      post_init
    end
  
    def close_connection
      @connection_open = false
    end

  
    def fake_recv_auth username
      receive_data [0x02, username.length, username.encode('UTF-16BE')].pack("Cna*")
    end

    def fake_bad_auth
      receive_data [0xFF].pack("C")
    end
  
  end
end