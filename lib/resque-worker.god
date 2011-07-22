root = File.expand_path '../', File.dirname(__FILE__)
redistogo_url = ENV['REDISTOGO_URL'] || "redis://redistogo:9b5f916f86dd29f26ca4af54c3f8f768@catfish.redistogo.com:9527/"
num_workers = 1

num_workers.times do |num|
  God.watch do |w|
    w.dir      = "#{root}"
    w.name     = "resque-#{num}"
    w.group    = 'resque'
    w.interval = 30.seconds
    w.env      = {"QUEUE"=>"worlds_to_import", "REDISTOGO_URL" => redistogo_url}
    w.start    = "rake resque:work"
    
    w.log_cmd = "/usr/bin/logger -t '#{w.name}'"

    # retart if memory gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        c.above = 350.megabytes
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