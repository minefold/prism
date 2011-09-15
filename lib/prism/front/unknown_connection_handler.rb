# encoding: UTF-8
module Prism
  class UnknownConnectionHandler < Handler
  
    def receive_data data
      connection.buffered_data << data
      
      header = data.unpack('C').first
      if header == 0x02
        username = data[3..-1].force_encoding('UTF-16BE').encode('UTF-8')
        new_handler KnownPlayerHandler, username
      elsif header == 0xFE
        connection.send_data MinecraftPackets.create_server 0xFF, :reason => "Minefold!§555§1337"
        connection.close_connection_after_writing
      else
        connection.close_connection
        StatsD.increment 'connections.unknown_client'
      end
    end
  end
end