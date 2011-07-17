
class WorkersCommand
  def show
    info = Workers.running.map do |w|
      worlds = w.worlds || []
      uptime_minutes = w.uptime_minutes
      {
        instance_id: w.instance_id,
        public_ip_address: w.public_ip_address,
        worlds: worlds.count,
        uptime: "#{uptime_minutes / 60}:#{uptime_minutes % 60}"
      }
    end
    
    puts Hirb::Helpers::AutoTable.render(info)
  end
  
end

