ROOT = File.expand_path '../../', File.dirname(__FILE__)

God.pid_file_directory = "#{ENV['HOME']}/.god/pids"

God.watch do |w|
  w.name = "proxy"
  w.interval = 5.seconds

  w.start = "bundle exec #{ROOT}/bin/proxy"
  w.log_cmd = '/usr/bin/logger -t proxy'
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