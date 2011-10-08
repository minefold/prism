module Prism
  
  module Sweeper 
    include Debugger
    
    attr_reader :redis_universe, 
                :boxes, :running_boxes, :working_boxes, :broken_boxes, :sleeping_boxes,
                :running_worlds
    
    def redis; Prism.redis; end
    
    def perform_sweep
      Prism::RedisUniverse.collect do |universe|
        @redis_universe = universe
        Box.all method(:query_boxes)
      end

      @deferred_sweep = EM::DefaultDeferrable.new
    end
    
    def query_boxes boxes
      @boxes = boxes
      
      @running_boxes, @working_boxes, @broken_boxes, @sleeping_boxes, @running_worlds = [], [], [], [], {}
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
          elsif state == 'stopped'
            @sleeping_boxes << box
            iter.next
          else
            iter.next
          end
        end
      }, method(:update_state))
    end

    def update_state
      # found boxes
      new_boxes = running_boxes.reject{|w| redis_universe.boxes[:running].keys.include? w.instance_id }
      new_boxes.each do |box|
        debug "found box:#{box.instance_id}"
        redis.hset_hash "workers:running", box.instance_id, instance_id:box.instance_id, host:box.host, started_at:box.started_at, instance_type:box.instance_type
      end
      
      # lost boxes
      lost_box_ids = redis_universe.boxes[:running].keys - running_boxes.map(&:instance_id)
      lost_box_ids.each do |instance_id|
        debug "lost box:#{instance_id}"
        redis.hdel "workers:running", instance_id
      end
      
      # lost busy boxes
      lost_busy_box_ids = redis_universe.boxes[:busy].keys - running_boxes.map(&:instance_id)
      lost_busy_box_ids.each do |instance_id|
        debug "lost busy box:#{instance_id}"
        redis.hdel "workers:busy", instance_id
      end
      
      # found worlds
      new_worlds = running_worlds.reject{|world_id, world| redis_universe.worlds[:running].keys.include? world_id }
      new_worlds.each do |world_id, world|
        debug "found world:#{world_id}"
        redis.hset_hash "worlds:running", world_id, instance_id:world['instance_id'], host:world['host'], port:world['port']
      end
      
      # lost worlds
      lost_world_ids = redis_universe.worlds[:running].keys - running_worlds.keys
      lost_world_ids.each do |world_id|
        debug "lost world:#{world_id}"
        redis.hdel "worlds:running", world_id
        redis.del "worlds:#{world_id}:connected_players"
      end
      
      # lost busy worlds
      lost_busy_world_ids = redis_universe.worlds[:busy].keys - running_worlds.keys
      lost_busy_world_ids.each do |world_id|
        debug "lost busy world:#{world_id}"
        redis.hdel "worlds:busy", world_id
      end
      
      # found sleeping boxes
      new_sleeping_boxes = sleeping_boxes.reject{|instance_id| redis_universe.boxes[:sleeping].include? instance_id }
      new_sleeping_boxes.each do |box|
        debug "found sleeping box:#{box.instance_id}"
        redis.sadd "workers:sleeping", box.instance_id
      end
      
      # lost sleeping boxes
      lost_sleeping_box_ids = redis_universe.boxes[:sleeping].keys - sleeping_boxes
      lost_sleeping_box_ids.each do |instance_id|
        debug "lost sleeping box:#{instance_id}"
        redis.srem "workers:sleeping", instance_id
      end
      
      # fix broken boxes
      broken_boxes.each do |box|
        debug "ignoring broken box:#{box.instance_id}"
        # redis.lpush "workers:requests:fix", box.instance_id
      end
      
      # lost players
      # lost_players = running_boxes.values.flatten - redis_universe.players.keys
      # p lost_players
      
      # shutdown idle worlds
      running_worlds.select {|world_id, world| world['players'] && world['players'].size == 0 }.each do |world_id, world|
        if redis_universe.worlds[:busy].keys.include? world_id
          puts "box:#{world['instance_id']} world:#{world_id} is empty busy:#{redis_universe.worlds[:busy][:world_id]}"
        else
          puts "box:#{world['instance_id']} world:#{world_id} stopping empty"
          redis.lpush "workers:#{world['instance_id']}:worlds:requests:stop", world_id
        end
      end

      # shutdown idle boxes
      if running_boxes.size > 0
        running_boxes.each do |box|
          uptime_minutes = ((Time.now - box.started_at) / 60).to_i
          close_to_end_of_hour = uptime_minutes % 60 > 55
          
          box_worlds = running_worlds.select {|world_id, w| w['instance_id'] == box.instance_id }
  
          world_count = box_worlds.size
          player_count = box_worlds.values.inject(0) {|sum, w| sum + (w['players'] || []).size }
      
          box_not_busy = redis_universe.boxes[:busy].count {|busy_box_id, world| busy_box_id == box.instance_id } == 0
       
          world_not_busy = redis_universe.worlds[:busy].count {|busy_world_id, data| data['instance_id'] == box.instance_id } == 0
  
          message = "box:#{box.instance_id} worlds:#{world_count} players:#{player_count} uptime_minutes:#{uptime_minutes}"
          if close_to_end_of_hour and world_count == 0 and box_not_busy and world_not_busy
            puts "#{message} terminating idle [IGNORE]"
            # redis.lpush "workers:requests:stop", box.instance_id
          else
            puts message
          end
        end
      else
        puts "No boxes running"
      end
      @deferred_sweep.succeed
    end
    
  end
end