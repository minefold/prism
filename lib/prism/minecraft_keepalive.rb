module Prism
  module MinecraftKeepalive
    extend Debugger
    
    def start_keepalive
      @keepalive = EM::PeriodicTimer.new 15 do
        debug "ping"
        connection.send_data [0].pack('C')
      end
    end
    
    def stop_keepalive
      @keepalive.cancel if @keepalive
    end
  end
end