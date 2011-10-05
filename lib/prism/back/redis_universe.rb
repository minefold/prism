require 'eventmachine/multi'

module Prism
  class RedisUniverse
    def self.collect *c, &b
      cb = EM::Callback(*c, &b)
      redis = Prism.redis

      op = redis.keys("worlds:*:connected_players")
      op.callback do |connected_players_keys| 
        multi = EventMachine::Multi.new
        multi.add :running_boxes,  redis.hgetall_json('workers:running')
        multi.add :sleeping_boxes, redis.hgetall_json('workers:sleeping')
        multi.add :busy_boxes,     redis.hgetall_json('workers:busy')
        multi.add :running_worlds, redis.hgetall_json( 'worlds:running')
        multi.add :busy_worlds,    redis.hgetall_json( 'worlds:busy')

        connected_players_keys.each {|key| multi.add key, redis.smembers(key) }

        multi.callback { |results| cb.call RedisUniverse.new results }
      end
      cb
    end

    attr_reader :boxes, :worlds, :players

    def initialize results = {}
      @boxes = { 
         running: results[:running_boxes],
        sleeping: results[:sleeping_boxes],
            busy: results[:busy_boxes]
      }

      @worlds = { 
        running: results[:running_worlds],
           busy: results[:busy_worlds]
      }

      world_players = results.each_with_object({}) do |(key, player_ids), hash| 
        key =~ /worlds:(.*):connected_players/
        if $1
          hash[$1] ||= []
          hash[$1] += player_ids 
        end
      end

      @worlds[:running].each do |world_id, world|
        @worlds[:running][world_id][:players] = world_players[world_id]
      end

      @boxes[:running].each do |instance_id, box|
        @boxes[:running][instance_id][:worlds] = @worlds[:running].select {|world_id, world| world['instance_id'] == instance_id }
      end
    end
  end
end