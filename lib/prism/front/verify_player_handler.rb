module Prism
  class VerifyPlayerHandler < Handler
    include Messaging
    include EM::P::Minecraft::Packets::Server

    def init token, username
      Resque.push 'high',
        class: 'LinkMinecraftPlayerJob',
        args: [token, username]

      listen_once "players:verification_request:#{token}" do |response|
        connection.send_data server_packet(0xFF, reason: response)
      end
    end
  end
end