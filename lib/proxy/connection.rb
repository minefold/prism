require 'colored'

HANDSHAKE = 0x02
DISCONNECT = 0xFF

module Proxy
  class Connection < EventMachine::Connection

    attr_reader :connected

    def initialize
      @connected = EM::DefaultDeferrable.new
      super
    end

    def receive_data(data)
      puts [:received, data].inspect.yellow

      @backend.send(data) if @backend

      msg = data.unpack('C*')

      case msg[0]
      when HANDSHAKE
        @username = data[3..-1]
        puts "#{@username} connected, starting server"

        @backend = EventMachine.connect('localhost', 3000, Proxy::Backend) do |s|
          s.plexer = self
          s.users << @username
        end

      when DISCONNECT
        @backend.disconnect(@username)
      end

      @backend.send data
    end

    def unbind
      @backend.disconnect(@username)
      puts "#{@username} disconnected, stopping server"
    end

    def backend_started
      @connected.succeed
    end

    def send(data)
      @connected.callback { send_data data }
    end

    def send_data(data)
      super(data)
      puts [:sent, data].inspect.blue
    end

  end
end
