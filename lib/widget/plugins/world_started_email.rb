module Widget
  class WorldStartedEmail < WorldPlugin

    def world_started
      puts "PLUGIN: world_started"
      # @timer = EM.add_periodic_timer(3 * 60) do
      #   @timer.cancel
      #   Resque.push 'mailer', class: 'WorldMailer', args: ['world_started', world_id]
      # end
    end
    
    def world_stopped
      puts "PLUGIN: world_stopped"
      # @timer.cancel if @timer
    end
  end
end