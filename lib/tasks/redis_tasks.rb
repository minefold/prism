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
    redis.keys.reject {|key| key =~ /resque/ }.sort.each do |key|
      type = redis.type key
      
      puts "#{key} [#{type}]"
      
      case type
      when 'hash'
        p redis.hgetall(key)
      when 'list'
        length = redis.llen key
        p redis.lrange(key, 0, length)
      when 'set'
        p redis.smembers key
      end
      puts
    end
  end
end