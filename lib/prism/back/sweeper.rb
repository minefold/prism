require 'core_ext'
require 'bytes'

module Prism
  class Sweeper
    include Debugger

    attr_reader :redis_universe,
                :boxes, :running_boxes, :working_boxes, :broken_boxes,
                :running_worlds

    def redis; Prism.redis; end

    def perform_sweep *a, &b
      @sweep_op = EM::Callback *a, &b
      Prism::RedisUniverse.collect do |universe|
        @redis_universe = universe
        Box.all method(:query_boxes)
      end
      @sweep_op
    end

    def query_boxes boxes
      @boxes = boxes

      @running_boxes, @working_boxes, @broken_boxes, @running_worlds = [], [], [], {}
      EM::Iterator.new(boxes).each(proc{ |box,iter|
        box.query_state do |state|
          if state == 'running'
            @running_boxes << box
            op = box.query_worlds
            op.callback do |worlds|
              @working_boxes << box
              @running_worlds.merge! worlds

              iter.next
            end
            op.errback do
              @broken_boxes << box
              iter.next
            end
          elsif state.nil?
            @broken_boxes << box
            iter.next
          else
            iter.next
          end
        end
      }, method(:update_state))
    end

    def update_state
      update_boxes
      lost_boxes
      lost_busy_boxes

      found_worlds
      lost_worlds
      lost_busy_worlds

      fix_broken_boxes

      shutdown_idle_worlds

      # wait 5 seconds so redis is definitely up to date
      # this would be better as a multi query, waiting for all of these
      # tasks to finish

      EM.add_timer(5) do
        RedisUniverse.collect do |universe|
          @redis_universe = universe
          WorldAllocator.new(universe).rebalance_boxes
          @sweep_op.call
        end
      end
    end

    def update_boxes
      running_boxes.each do |box|
        debug "found box:#{box.instance_id}" unless redis_universe.boxes[:running].keys.include? box.instance_id
        redis.store_running_box box
      end
    end

    def lost_boxes
      lost_box_ids = redis_universe.boxes[:running].keys - running_boxes.map(&:instance_id)
      lost_box_ids.each do |instance_id|
        debug "lost box:#{instance_id}"
        host = redis_universe.boxes[:running][instance_id]['host']
        redis.unstore_running_box instance_id, host
      end
    end

    def lost_busy_boxes
      lost_busy_box_ids = redis_universe.boxes[:busy].keys - running_boxes.map(&:instance_id)
      lost_busy_box_ids.each do |instance_id|
        busy_hash = redis_universe.boxes[:busy][instance_id]
        busy_length = Time.now - Time.at(busy_hash['at'])
        if busy_length > busy_hash['expires_after']
          debug "lost busy box:#{instance_id}"
          redis.hdel "workers:busy", instance_id
        else
          debug "busy box:#{instance_id} (#{busy_hash['state']} #{busy_length} seconds)"
        end
      end
    end

    def found_worlds
      new_worlds = running_worlds.reject{|world_id, world| redis_universe.worlds[:running].keys.include? world_id }
      new_worlds.each do |world_id, world|
        
        if world_id != 'disk' # TODO: this line is temp
          debug "found world:#{world_id}"
          redis.store_running_world world['instance_id'], world_id, world['host'], world['port']
        end
      end
    end

    def lost_worlds
      lost_world_ids = redis_universe.worlds[:running].keys - running_worlds.keys
      lost_world_ids.each do |world_id|
        instance_id = redis_universe.worlds[:running][world_id]['instance_id']

        debug "lost world:#{world_id} instance:#{instance_id}"
        redis.unstore_running_world instance_id, world_id
      end
    end

    def lost_busy_worlds
      lost_busy_world_ids = redis_universe.worlds[:busy].keys - running_worlds.keys
      lost_busy_world_ids.each do |world_id|
        busy_hash = redis_universe.worlds[:busy][world_id]
        busy_length = Time.now - Time.at(busy_hash['at'])
        if busy_length > busy_hash['expires_after']
          debug "lost busy world:#{world_id}"
          redis.hdel "worlds:busy", world_id
        else
          debug "busy world:#{world_id} (#{busy_hash['state']} #{busy_length} seconds)"
        end
      end
    end

    def fix_broken_boxes
      broken_boxes.each do |box|
        debug "ignoring broken box:#{box.instance_id}"
      end
    end

    def shutdown_idle_worlds
      # if any worlds previously declared as empty have become unempty, clear busy state
      running_worlds = redis_universe.worlds[:running]
      running_worlds.select {|world_id, world| world[:players].any? }.each do |world_id, world|
        if busy_hash = redis_universe.worlds[:busy][world_id]
          redis.hdel 'worlds:busy', world_id if busy_hash['state'] == 'empty'
        end
      end

      running_worlds.select {|world_id, world| world[:players].empty? }.each do |world_id, world|
        if busy_hash = redis_universe.worlds[:busy][world_id]
          busy_length = Time.now - Time.at(busy_hash['at'])
          debug "busy world:#{world_id} (#{busy_hash['state']} #{busy_length} seconds)"

          if busy_length > busy_hash['expires_after']
            debug "box:#{world['instance_id']} world:#{world_id} stopping empty world"
            redis.lpush "workers:#{world['instance_id']}:worlds:requests:stop", world_id
          end
        else
          debug "box:#{world['instance_id']} world:#{world_id} is empty"
          redis.set_busy "worlds:busy", world_id, 'empty', expires_after: 60
        end
      end
    end

    def record_stats
      running_boxes = redis_universe.boxes[:running]
      StatsD.measure "boxes.count", running_boxes.size
      running_boxes.values.group_by {|b| b['instance_type'] }.each do |instance_type, group|
        StatsD.measure "boxes.#{instance_type.gsub('.','-')}.count", group.size
      end
      StatsD.measure "players.count", redis_universe.players.size
      StatsD.measure "worlds.count",  redis_universe.worlds[:running].size
    end

  end
end