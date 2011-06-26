ROOT = File.expand_path '../../', File.dirname(__FILE__)

God.watch do |w|
  w.name = "proxy"
  w.interval = 5.seconds # default

  w.start = "bundle exec #{ROOT}/bin/proxy"
  w.log = "#{ROOT}/proxy/log/proxy.log"
  w.dir = ROOT

  # Cleanup the pid file (this is needed for processes running as a daemon)
  w.behavior(:clean_pid_file)

  # Conditions under which to start the process
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.running = false
    end
  end
end