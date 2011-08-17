module Prism
  class UnknownPlayerHandler < Handler
  
    def receive_data data
      header = data.unpack('C').first
      return connection.close_connection unless header == 0x02

      username = data[3..-1].force_encoding('UTF-16BE').encode('UTF-8')
    
      @on_change_handler.call KnownPlayerHandler, username
    end
  end
end