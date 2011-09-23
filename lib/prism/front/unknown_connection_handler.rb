# encoding: UTF-8
module Prism
  class UnknownConnectionHandler < Handler
    include Minecraft::Packets::Server
    
    def receive_data data
      connection.buffered_data << data
      
      header = data.unpack('C').first
      if header == 0x02
        username = data[3..-1].force_encoding('UTF-16BE').encode('UTF-8')
        new_handler KnownPlayerHandler, username
      elsif header == 0xFE
        op = redis.hlen "players:playing"
        op.callback do |player_count|
          connection.send_data server_packet 0xFF, :reason => "Minefold!§#{player_count}§100000"
          connection.close_connection_after_writing
        end
      else
        connection.close_connection
        StatsD.increment 'connections.unknown_client'
      end
    end
  end
end