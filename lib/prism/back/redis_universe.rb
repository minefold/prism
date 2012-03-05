require 'eventmachine/multi'

module Prism
  class RedisUniverse
    def self.collect timeout = 10, *c, &b
      cb = EM::Callback(*c, &b)
      redis = Prism.redis

      @timeout = EM.add_periodic_timer(timeout) {
        puts "timeout colecting redis state"
        EM.stop
      }

      op = redis.keys("worlds:*:connected_players")
      op.callback do |connected_players_keys|
        multi = EventMachine::Multi.new
        multi.add :running_boxes,  redis.hgetall_json('workers:running')
        multi.add :busy_boxes,     redis.hgetall_json('workers:busy')
        multi.add :running_worlds, redis.hgetall_json( 'worlds:running')
        multi.add :busy_worlds,    redis.hgetall_json( 'worlds:busy')

        connected_players_keys.each {|key| multi.add key, redis.smembers(key) }

        multi.callback do |results|
          @timeout.cancel
          cb.call RedisUniverse.new results
        end
      end
      cb
    end

    attr_reader :boxes, :worlds, :players

    def initialize results = {}
      @boxes = {
         running: results[:running_boxes],
            busy: results[:busy_boxes]
      }

      @worlds = {
        running: results[:running_worlds],
           busy: results[:busy_worlds]
      }

      @players = {}

      world_players = results.each_with_object({}) do |(key, player_ids), hash|
        key =~ /worlds:(.*):connected_players/
        if world_id = $1
          hash[world_id] ||= []
          hash[world_id] += player_ids

          @players.merge! player_ids.each_with_object({}) {|player_id, hash| hash[player_id] = world_id  }
        end
      end

      @worlds[:running].each do |world_id, world|
        @worlds[:running][world_id][:players] = world_players[world_id] || []
      end
      
      @boxes[:running].each do |instance_id, box|
        @boxes[:running][instance_id][:worlds]  = @worlds[:running].select {|world_id, world| world['instance_id'] == instance_id }
        @boxes[:running][instance_id][:players] = @boxes[:running][instance_id][:worlds].inject([]) do |acc, (world_id, world)|
          acc | world[:players]
        end
      end
    end
  end
end