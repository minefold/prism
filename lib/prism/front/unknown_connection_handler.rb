require 'minecraft'

# encoding: UTF-8
module Prism
  class UnknownConnectionHandler < Handler
    include EM::P::Minecraft::Packets::Server

    def connection_error error
      connection.send_data server_packet 0xFF, :reason => error
      connection.close_connection_after_writing
    end

    def receive_data data
      connection.buffered_data << data

      header = connection.buffered_data.unpack('C').first
      if header == 0x02
        begin
          receive_login connection.buffered_data
        rescue => e
          puts "#{e}\n#{e.backtrace.join("\n")}"
          Exceptional.handle(e)
          connection_error "Minefold Protocol Error"
        end

      elsif header == 0xFE
        connection_error "minefold.com"

      else
        connection.close_connection
        StatsD.increment 'connections.unknown_client'
      end
    end

    def receive_login data
      begin
        receive_126_login data
      rescue Encoding::InvalidByteSequenceError
        receive_125_login data
      end
    end

    def receive_126_login data
      login_packet = Minecraft::MinecraftPacket.new 0x02,
        :protocol_version => :byte,
        :username => :string,
        :host => :string,
        :port => :int

      values = login_packet.parse data

      new_handler KnownPlayerHandler, values[:username], "#{values[:host]}:#{values[:port]}"
    end

    def receive_125_login data
      login_packet = Minecraft::MinecraftPacket.new 0x02, :username => :string

      values = login_packet.parse data

      username = values[:username]

      target_host = nil
      if username.include?(';')
        username, target_host = username.split(';', 2)
      end
      new_handler KnownPlayerHandler, username, target_host
    end
  end
end