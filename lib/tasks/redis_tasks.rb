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
    %W[players:playing
       usernames
       worlds:running
       worlds:busy
       workers:running
       workers:busy
    ].each do |hash|
      puts hash
      p redis.hgetall(hash)
      puts
    end
    
    %w[players:connection_request
       players:disconnection_request
       players:world_request
       worlds:requests:start
       worlds:requests:stop
       workers:requests:fix
       workers:requests:start
       workers:requests:stop
       workers:requests:create].each do |list|
      length = redis.llen list
      puts list
      p redis.lrange(list, 0, length)
      puts
    end
    
    redis.keys("worlds:*:connected_players").each do |key|
      puts "#{key} #{redis.smembers key}"
    end
    
  end
end