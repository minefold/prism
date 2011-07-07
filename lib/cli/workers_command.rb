
class WorkersCommand
  def show
    info = Workers.running.map do |w|
      worlds = w.worlds || []
      uptime = w.uptime
      {
        instance_id: w.instance_id,
        public_ip_address: w.public_ip_address,
        worlds: worlds.count,
        "uptime (minutes)" => uptime / 60
      }
    end
    
    puts Hirb::Helpers::AutoTable.render(info)
  end
  
end

