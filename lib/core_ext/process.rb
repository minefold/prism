module Process
  def self.alive?(pid)
    begin
      Process.kill(0, pid)
      true
    rescue Errno::ESRCH
      false
    end
  end
  
  def self.spawn_detached dir, cmd
    process = fork do
      Dir.chdir dir
      exec cmd
    end
    Process.detach process
  end
end