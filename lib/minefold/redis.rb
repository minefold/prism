module Minefold
  module Redis
    def redis
      @redis ||= begin
        uri = URI.parse(REDISTOGO_URL)
        ::Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      end
    end
    
    def send_world_player_message world_id, username, body
      redis.publish "world.#{world_id}.input", "tell #{username} #{body}"
    end
    
  end
end