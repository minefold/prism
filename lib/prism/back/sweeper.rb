module Prism
  class Sweeper 
    include Debugger
    
    attr_reader :redis_universe, 
                :boxes, :running_boxes, :working_boxes, :broken_boxes,
                :running_worlds
    
    def redis; Prism.redis; end
    
    def perform_sweep
      Prism::RedisUniverse.collect do |universe|
        @redis_universe = universe
        Box.all method(:query_boxes)
      end
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
      EM.add_timer(10) do
        # wait 10 seconds so redis is definitely up to date
        RedisUniverse.collect {|universe| WorldAllocator.new(universe).rebalance_boxes }
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
        debug "lost busy box:#{instance_id}"
        redis.hdel "workers:busy", instance_id
      end
    end
    
    def found_worlds
      new_worlds = running_worlds.reject{|world_id, world| redis_universe.worlds[:running].keys.include? world_id }
      new_worlds.each do |world_id, world|
        debug "found world:#{world_id}"
        redis.store_running_world world['instance_id'], world_id, world['host'], world['port']
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
        debug "lost busy world:#{world_id}"
        redis.hdel "worlds:busy", world_id
      end
    end
    
    def fix_broken_boxes
      broken_boxes.each do |box|
        debug "ignoring broken box:#{box.instance_id}"
        # redis.lpush "workers:requests:fix", box.instance_id
      end
    end
    
    def shutdown_idle_worlds
      running_worlds.select {|world_id, world| world['players'] && world['players'].size == 0 }.each do |world_id, world|
        if redis_universe.worlds[:busy].keys.include? world_id
          puts "box:#{world['instance_id']} world:#{world_id} is empty busy:#{redis_universe.worlds[:busy][:world_id]}"
        else
          puts "box:#{world['instance_id']} world:#{world_id} stopping empty"
          redis.lpush "workers:#{world['instance_id']}:worlds:requests:stop", world_id
        end
      end
    end
    
  end
end