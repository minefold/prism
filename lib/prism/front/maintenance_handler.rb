require 'minecraft'

# encoding: UTF-8
module Prism
  class MaintenanceHandler < Handler
    include EM::P::Minecraft::Packets::Server

    def init message
      @message = message
    end
    
    def kick message
      connection.send_data server_packet 0xFF, reason: message
      connection.close_connection_after_writing
    end

    def receive_data data
      connection.buffered_data << data

      header = connection.buffered_data.unpack('C').first
      if header == 0x02
        kick @message || "Minefold is currently undergoing maintenance. Visit minefold.com"

      elsif header == 0xFE
        kick server_ping_msg('49', '1_4_4', 'minefold.com')

      else
        connection.close_connection
      end
    end

    def server_ping_msg protocol_version, minecraft_version, msg
      header = "\u00A71"
      players = -1 # shows as ??? in the client
      [ header,
        protocol_version,
        minecraft_version,
        msg,
        players,
        players ].join("\u0000")
    end
  end
end