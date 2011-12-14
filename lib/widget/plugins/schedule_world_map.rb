module Widget
  class ScheduleWorldMap < WorldPlugin
    def world_backed_up
      puts "scheduling world mapping"
      Resque.enqueue Job::MapWorld, world_id
    end
  end
end