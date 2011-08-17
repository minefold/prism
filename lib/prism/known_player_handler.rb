module Prism
  class KnownPlayerHandler < Handler
    attr_reader :username
    
    def init username
      @username = username
      
      redis = EM::Hiredis.connect
      redis.callback { redis.lpush "players:requesting_world", username }
      
      redis.subscribe("players:requesting_world_result:#{username}")
      
    end
  end
end