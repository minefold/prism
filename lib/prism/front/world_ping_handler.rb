module Prism
  class WorldPingHandler < Handler
    def init host, port
      packet = Minecraft::Packet.new(0xFE).create
      
      EM.rpc_packet host, port, packet, 2 do |result|
        connection.send_data result
        connection.close_connection_after_writing
      end
    end
  end
end