root = File.expand_path '../', File.dirname(__FILE__)
uid = File.read(File.expand_path('~/FOLD_WORKER_USER')).strip
fold_env = File.read(File.expand_path('~/FOLD_ENV')).strip

God.pid_file_directory = File.expand_path "#{root}/../tmp/pids"
God.watch do |w|
  w.name = "worker-app"
  w.interval = 5.seconds # default
  w.start = "bundle exec thin start -p 3000"
  w.log_cmd = "/usr/bin/logger -t '#{w.name}'"
  w.dir = root
  
  w.uid = uid
  
  w.env = {
    'FOLD_ENV' => fold_env, 'FOLD_WORKER_USER' => uid,
  }
  
  w.behavior(:clean_pid_file)
  
  # determine the state on startup
  w.transition(:init, { true => :up, false => :start }) do |on|
    on.condition(:process_running) do |c|
      c.running = true
    end
  end
  
  # determine when process has finished starting
  w.transition([:start, :restart], :up) do |on|
    on.condition(:process_running) do |c|
      c.running = true
    end
    
    # failsafe
    on.condition(:tries) do |c|
      c.times = 5
      c.transition = :start
    end
  end

  # start if process is not running
  w.transition(:up, :start) do |on|
    on.condition(:process_running) do |c|
      c.running = false
    end
  end
  
  # restart if memory or cpu is too high
  # w.transition(:up, :restart) do |on|
  #   on.condition(:memory_usage) do |c|
  #     c.interval = 20
  #     c.above = 50.megabytes
  #     c.times = [3, 5]
  #   end
  #   
  #   on.condition(:cpu_usage) do |c|
  #     c.interval = 10
  #     c.above = 10.percent
  #     c.times = [3, 5]
  #   end
  # end
  
  # lifecycle
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end

num_workers = 1
num_workers.times do |num|
  God.watch do |w|
    w.name     = "resque-#{num}"
    w.group    = 'resque'
    w.interval = 30.seconds
    w.dir      = root
    w.env      = {"QUEUE"=>"worlds_to_map", "FOLD_ENV"=>fold_env}
    w.start    = "bundle exec rake resque:work"
    w.log_cmd = "/usr/bin/logger -t '#{w.name}'"

    w.uid = uid

    # retart if memory gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        c.above = 250.megabytes
        c.times = 2
      end
    end

    # determine the state on startup
    w.transition(:init, { true => :up, false => :start }) do |on|
      on.condition(:process_running) do |c|
        c.running = true
      end
    end

    # determine when process has finished starting
    w.transition([:start, :restart], :up) do |on|
      on.condition(:process_running) do |c|
        c.running = true
        c.interval = 5.seconds
      end

      # failsafe
      on.condition(:tries) do |c|
        c.times = 5
        c.transition = :start
        c.interval = 5.seconds
      end
    end

    # start if process is not running
    w.transition(:up, :start) do |on|
      on.condition(:process_running) do |c|
        c.running = false
      end
    end
  end
end