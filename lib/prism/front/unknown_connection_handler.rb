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
        connection_error server_ping_msg('47', '1_4_1', 'minefold.com')

      elsif header == 0xE0
        begin
          # 0xE0 packet is internal, routes to brain
          test_packet = Minecraft::Packet.new 0xE0,
            :host => :string,
            :port => :int,
            :payload => :string

          packet = test_packet.parse(connection.buffered_data)

          new_handler SystemTestHandler, packet[:host], packet[:port], packet[:payload]

        rescue => e
          puts "#{e}\n#{e.backtrace.join("\n")}"
          Exceptional.handle(e)
          connection_error "Minefold Test Protocol Error"
        end

      elsif header == 0xE1
        begin
          # 0xE1 packet is internal, pings a running world
          test_packet = Minecraft::Packet.new 0xE1,
            :host => :string,
            :port => :int

          packet = test_packet.parse(connection.buffered_data)

          new_handler WorldPingHandler, packet[:host], packet[:port]

        rescue => e
          puts "#{e}\n#{e.backtrace.join("\n")}"
          Exceptional.handle(e)
          connection_error "Minefold Test Protocol Error"
        end

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
      login_packet = Minecraft::Packet.new 0x02,
        :protocol_version => :byte,
        :username => :string,
        :host => :string,
        :port => :int

      values = login_packet.parse data

      new_handler KnownPlayerHandler, values[:username], "#{values[:host]}:#{values[:port]}"
    end

    def receive_125_login data
      login_packet = Minecraft::Packet.new 0x02, :username => :string

      values = login_packet.parse data

      username = values[:username]

      target_host = nil
      if username.include?(';')
        username, target_host = username.split(';', 2)
      end
      new_handler KnownPlayerHandler, username, target_host
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