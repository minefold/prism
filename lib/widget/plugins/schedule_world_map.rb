module Widget
  class ScheduleWorldMap < WorldPlugin
    def world_started
      @started_at = Time.now
    end
    
    def elapsed_seconds
      (Time.now - (@started_at || Time.now)).to_i
    end
    
    def world_backed_up
      if elapsed_seconds > 120
        puts "scheduling world mapping"
        Resque.enqueue Job::MapWorld, world_id
      end
    end
  end
end