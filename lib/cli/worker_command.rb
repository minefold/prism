class WorkerCommand
  attr_reader :instance_id
  
  def initialize instance_id
    @instance_id = instance_id
  end
  
  def show
    if w = worker
      puts Hirb::Helpers::AutoTable.render({
        instance_id:w.instance_id, 
        public_ip_address:w.public_ip_address,
        worlds:w.worlds.map{|world| world.id }
      })
    end
  end
  
  def stop
    worker.server.stop
  end
  
  def terminate
    worker.server.destroy
  end
  
  def ssh
    exec %Q{ssh -i #{ROOT}/.ssh/minefold.pem ubuntu@#{worker.public_ip_address}}
  end
  
  private
  
  def worker
    Worker.running.find {|w| w.instance_id == instance_id}
  end
end