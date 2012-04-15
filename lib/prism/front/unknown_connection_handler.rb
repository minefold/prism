# encoding: UTF-8
module Prism
  class UnknownConnectionHandler < Handler
    include EM::P::Minecraft::Packets::Server

    def receive_data data
      connection.buffered_data << data

      header = data.unpack('C').first
      if header == 0x02
        raw_user_data = data[3..-1]
        if raw_user_data
          username = raw_user_data.force_encoding('UTF-16BE').encode('UTF-8')
          target_host = nil
          if username.include?(';')
            username, target_host = username.split(';', 2)
          end
          new_handler KnownPlayerHandler, username, target_host
        else
          connection.send_data server_packet 0xFF, :reason => "Protocol Error"
          connection.close_connection_after_writing
          Exceptional.rescue { raise "Invalid connection packet: #{data}" }
        end
      elsif header == 0xFE
        # p data
        connection.send_data server_packet 0xFF, :reason => "minefold.com"
        connection.close_connection_after_writing
      else
        connection.close_connection
        StatsD.increment 'connections.unknown_client'
      end
    end
  end
end