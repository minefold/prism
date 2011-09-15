module Prism
  module MinecraftKeepalive
    extend Debugger
    
    def start_keepalive
      @keepalive = EM::PeriodicTimer.new 3 do
        debug "ping"
        connection.send_data MinecraftPackets.create_server 0x00, :keepalive_id => 1337
      end
    end
    
    def stop_keepalive
      @keepalive.cancel if @keepalive
    end
  end
end