module Prism
  module MinecraftKeepalive
    include Minecraft::Packets::Server
    
    extend Debugger
    
    def start_keepalive
      started_at = Time.now
      @keepalive = EM::PeriodicTimer.new 15 do
        debug "ping - #{(Time.now - started_at)} seconds"
        connection.send_data server_packet 0x00, :keepalive_id => 1337
      end
    end
    
    def stop_keepalive
      @keepalive.cancel if @keepalive
    end
  end
end