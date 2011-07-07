class WorkerCommand
  attr_reader :instance_id
  
  def initialize instance_id
    @instance_id = instance_id
  end
  
  def show
    w = worker
    if w
      puts Hirb::Helpers::AutoTable.render({
        instance_id:w.instance_id, 
        public_ip_address:w.public_ip_address,
        worlds:w.worlds.map{|world| world_id }
      })
    end
  end
  
  def stop
    worker.server.stop
  end
  
  def terminate
    worker.server.destroy
  end
  
  private
  
  def worker
    Workers.running.find {|w| w.instance_id == instance_id}
  end
end