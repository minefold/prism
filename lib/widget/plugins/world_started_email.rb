module Widget
  class WorldStartedEmail < WorldPlugin
    def world_started
      @timer = EM.add_periodic_timer(3 * 60) do
        @timer.cancel
        puts "scheduling job:world_started #{world_id}"
        Resque.push 'low', class: 'WorldStartedJob', args: [world_id]
      end
    end
    
    def world_stopped
      @timer.cancel if @timer
    end
  end
end