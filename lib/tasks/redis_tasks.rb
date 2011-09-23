namespace "redis" do
  
  task "monitor_clients" do
    redis = redis_connect
    while true
      puts "clients: #{redis.info['connected_clients']}"
      sleep 1
    end
  end
  
  
  desc "Dump minefold specific keys"
  task "state" do
    redis = redis_connect
    puts "clients: #{redis.info['connected_clients']}"
    ["players:playing",
     "prism:active_connections",
     "worlds:running", "worlds:busy",
     "workers:running", "workers:busy"].each do |hash|
       puts hash
       p redis.hgetall(hash)
       puts
    end

    ["players:minute_played", "players:requesting_connection", "players:disconnection_request"].each do |list|
      length = redis.llen list
      puts list
      p redis.lrange(list, 0, length)
      puts
    end
    
  end
end