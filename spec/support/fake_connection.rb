module EM
  class FakeConnection
    attr_reader :connection_open

    def initialize handler, *args
      extend handler
      @connection_open = true
      
      post_init
    end
    
    def send_data data
      
    end
  
    def close_connection
      @connection_open = false
    end
    
    def signature
      1
    end

  
    def fake_recv_auth username
      receive_data [0x02, username.length, username.encode('UTF-16BE')].pack("Cna*")
    end

    def fake_bad_auth
      receive_data [0xFF].pack("C")
    end
  
  end
end