module Proxy

  class Process < EventMachine::Connection
    attr_accessor :backend

    def receive_data(data)
      puts data
      @backend.process_spawned if data =~ /\[INFO\] Done/
    end
  end

  class Backend < EventMachine::Connection
    attr_accessor :plexer, :data

    attr_accessor :users

    def initialize
      @connected = EM::DefaultDeferrable.new
      @data, @users = [], []

      @process = EM.popen('/bin/sh -c "cd mc && java -Xmx1024M -Xms512M -jar server.jar nogui 2>&1"', Proxy::Process) do |p|
        p.backend = self
      end
   end

    def process_spawned
      reconnect '0.0.0.0', 3000
      @plexer.connected.succeed
      @connected.succeed
    end

    def receive_data(data)
      puts [:received, data].inspect.cyan

      @data << data
      @plexer.send data
    end

    def send_data(data)
      super(data)
      puts [:sent, data].inspect.green
    end

    # Buffer data until the connection to the backend server
    # is established and is ready for use
    def send(data)
      @connected.callback { send_data data }
    end

    # Notify upstream plexer that the backend server is done
    # processing the request
    def unbind
      @process.unbind
    end

    def disconnect(user)
      self.users.delete(user)
      unbind if users.empty?
    end

  end
end
