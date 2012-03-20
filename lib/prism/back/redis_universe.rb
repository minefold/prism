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

      redis.keys("widget:*:heartbeat") do |heartbeats|
        multi = EventMachine::Multi.new
        multi.add :running_boxes,   redis.hgetall_json('workers:running')
        multi.add :busy_boxes,      redis.hgetall_json('workers:busy')
        multi.add :running_worlds,  redis.hgetall_json( 'worlds:running')
        multi.add :busy_worlds,     redis.hgetall_json( 'worlds:busy')
        multi.add :players,         redis.hgetall('players:playing')
        multi.add :usernames,       redis.hgetall('usernames')

        heartbeats.each {|key| multi.add key, redis.get(key) }

        multi.callback do |results|
         @timeout.cancel
         cb.call RedisUniverse.new results
        end
      end
      cb
    end

    attr_reader :boxes, :worlds, :players, :widgets

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

      world_players = results[:players].each_with_object({}) do |(username, world_id), hash|
        # TODO: this lookup username => user_id shouldn't be necessary
        user_id = results[:usernames][username]
        @players[user_id] = world_id

        hash[world_id] ||= []
        hash[world_id] = hash[world_id] | [user_id]
      end

      @worlds[:running].each do |world_id, world|
        @worlds[:running][world_id][:players] = world_players[world_id] || []
        @worlds[:running][world_id][:box] = @boxes[:running][world['instance_id']]
      end

      @boxes[:running].each do |instance_id, box|
        @boxes[:running][instance_id][:worlds]  = @worlds[:running].select {|world_id, world| world['instance_id'] == instance_id }
        @boxes[:running][instance_id][:players] = @boxes[:running][instance_id][:worlds].inject([]) do |acc, (world_id, world)|
          acc | world[:players]
        end
      end

      @widgets = results.each_with_object({}) do |(key, heartbeat), h|
        key =~ /widget:(.*):heartbeat/
        if id = $1
          h[id] = JSON.parse heartbeat
        end
      end
    end
  end
end