module Prism
  module MinecraftKeepalive
    include EM::P::Minecraft::Packets::Server

    extend Debugger

    def start_keepalive username
      started_at = Time.now
      @keepalive = EM::PeriodicTimer.new 15 do
        connection_time = Time.now - started_at
        debug "ping - #{connection_time} seconds"
        connection.send_data server_packet 0x00, :keepalive_id => 1337
        if connection_time > 120
          Exceptional.rescue { raise "Player connection timeout: #{connection_time} seconds" }
          redis.publish_json "players:connection_request:#{username}", rejected:'500'
        end
      end
    end

    def stop_keepalive
      @keepalive.cancel if @keepalive
    end
  end
end