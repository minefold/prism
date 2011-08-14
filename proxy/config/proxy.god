ROOT = File.expand_path '../../', File.dirname(__FILE__)

fold_env = 'production'
God.pid_file_directory = "#{ROOT}/tmp/pids"

God.watch do |w|
  w.name = "proxy"
  w.interval = 5.seconds

  w.uid = 'ubuntu'
  w.env = {'FOLD_ENV' => fold_env }
  
  w.start = "bundle exec #{ROOT}/bin/proxy"
  w.log_cmd = "/usr/bin/logger -t '#{fold_env[0..2]}|#{w.name}'"
  w.dir = ROOT
  
  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.running = false
    end
  end
end

God.watch do |w|
  w.name = "statsd"
  w.interval = 5.seconds

  w.uid = 'ubuntu'
  
  w.dir = "/home/ubuntu/statsd"
  
  w.start = "node #{w.dir}/stats.js #{w.dir}/exampleConfig.js"
  w.log_cmd = "/usr/bin/logger -t '#{fold_env[0..2]}|#{w.name}'"
  
  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.running = false
    end
  end
end
