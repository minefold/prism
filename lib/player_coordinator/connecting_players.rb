module PlayerCoordinator
  class ConnectingPlayers
    include Debugger
    
    def start_processing
      @queue = EM::Hiredis.connect
      @queue.callback { listen }
    end
    
    def listen
      @pop = @queue.blpop "players:requesting_connection", 0
      @pop.callback do |channel, username|
        ConnectingPlayer.new username
        listen
      end
    end
  end
end