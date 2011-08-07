ROOT = File.expand_path '../../', File.dirname(__FILE__)

fold_env = ENV['FOLD_ENV'] || 'development'
God.pid_file_directory = "#{ROOT}/tmp/pids"

God.watch do |w|
  w.name = "proxy"
  w.interval = 5.seconds

  w.uid = 'ubuntu'
  w.env = {'FOLD_ENV' => 'production'}
  
  w.start = "bundle exec #{ROOT}/bin/proxy"
  w.log_cmd = "/usr/bin/logger -t '#{fold_env}|#{w.name}'"
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