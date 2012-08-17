require 'eventmachine/rpc'

module Prism
  class SystemTestHandler < Handler
    def init host, port, message
      EM.rpc host, port, message, 2 do |result|
        connection.send_data result
        connection.close_connection_after_writing
      end
    end
  end
end