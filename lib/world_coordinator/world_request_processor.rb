module WorldCoordinator
  class WorldRequestProcessor
    
    def start_processing
      @queue = EM::Hiredis.connect
      @queue.callback { listen }
    end
    
    def listen
      @pop = @queue.blpop "players:requesting_world", 0
      @pop.callback do |channel, message|
        data = JSON.parse message
        WorldRequest.new data['user_id'], data['world_id']
        listen
      end
    end
  end
end