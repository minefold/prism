namespace "redis" do
  desc "watch number of clients"
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
    redis.keys.sort.each do |key|
      type = redis.type key

      puts "#{key} [#{type}]"

      case type
      when 'string'
        p redis.get(key)
      when 'hash'
        p redis.hgetall(key)
      when 'list'
        length = redis.llen key
        p redis.lrange(key, 0, length)
      when 'set'
        p redis.smembers key
      when 'zset'
        p redis.zrange key, 0, -1
      end
      puts
    end
  end

  desc "deletes all keys"
  task :flush_all do
    raise 'this is fucking dangerous!'

    redis_connect.flushall
  end

  desc "gets rid of loner keys"
  task :delete_loners do
    redis = redis_connect
    redis.keys.grep(/resque:loners/).each {|key| puts "del #{key}"; redis.del key }
  end
end