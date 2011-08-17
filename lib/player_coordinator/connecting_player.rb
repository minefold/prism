module PlayerCoordinator
  class ConnectingPlayer
    include Debugger
    attr_reader :username
    
    alias_method :debug_original, :debug
    
    def debug *args
      debug_original "[#{@username}]", *args
    end
    
    def initialize username
      @username = username
      @db = EM::Mongo::Connection.new('localhost').db('minefold')
      
      process
    end
    
    def process
      debug "processing #{username}"

      resp = @db.collection('users').find_one(:username => /#{username}/i)
      resp.callback do |user|
        if user
          recognised_player_connecting user
        else
          unrecognised_player_connecting
        end
      end
        
      resp.errback{|err| raise err }
    end
    
    def recognised_player_connecting user
      debug "found user:#{user['_id']} world:#{user['world_id']}"
      
      redis = EM::Hiredis.connect
      redis.callback do 
        debug "waiting for world"
        redis.lpush "players:requesting_world", { 'username' => username, 'user_id' => user['_id'].to_s, 'world_id' => user['world_id'].to_s }.to_json
      end
    end
    
    def unrecognised_player_connecting
      debug "unrecognised"
    end
  end
end