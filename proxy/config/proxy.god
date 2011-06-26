ROOT = File.expand_path '../../', File.dirname(__FILE__)

God.watch do |w|
  w.name = "proxy"
  w.interval = 5.seconds # default

  w.start = "cd #{ROOT} && ./bin/proxy"

  # Cleanup the pid file (this is needed for processes running as a daemon)
  w.behavior(:clean_pid_file)

  # Conditions under which to start the process
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
end