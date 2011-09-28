module Prism
  module Sweeper 
    include Debugger
    
    attr_reader :redis_running_boxes, :redis_busy_boxes, :redis_running_worlds, :redis_busy_worlds, 
                :boxes, :running_boxes, :working_boxes, :broken_boxes,
                :running_worlds
    
    def redis; Prism.redis; end
    
    def perform_sweep
      @boxes, @running_boxes, @working_boxes, @broken_boxes, @running_worlds = [], [], [], [], {}
      
      redis.hgetall_json 'workers:running' do |redis_running_boxes|
        @redis_running_boxes = redis_running_boxes
        redis.hgetall_json 'workers:busy' do |redis_busy_boxes|
          @redis_busy_boxes = redis_busy_boxes
          redis.hgetall_json 'worlds:running' do |redis_running_worlds|
            @redis_running_worlds = redis_running_worlds
            redis.hgetall_json 'worlds:busy' do |redis_busy_worlds|
              @redis_busy_worlds = redis_busy_worlds
              Box.all method(:query_boxes)
            end
          end
        end
      end
      
      @deferred_sweep = EM::DefaultDeferrable.new
    end
    
    def query_boxes boxes
      @boxes = boxes
      EM::Iterator.new(boxes).each(proc{ |box,iter|
        if box.running?
          @running_boxes << box
          op = box.query_worlds
          op.callback do |worlds|
            @working_boxes << box
            @running_worlds.merge! worlds
            iter.next
          end
          op.errback do
            @broken_boxes << box
          end
        end
      }, method(:update_state))
    end

    def update_state
      lost_box_ids = redis_running_boxes.keys - running_boxes.map(&:instance_id)
      lost_box_ids.each do |instance_id|
        debug "lost box:#{instance_id}"
        redis.hdel "workers:running", instance_id
      end
      
      lost_busy_box_ids = redis_busy_boxes.keys - running_boxes.map(&:instance_id)
      lost_busy_box_ids.each do |instance_id|
        debug "lost busy box:#{instance_id}"
        redis.hdel "workers:busy", instance_id
      end
      
      new_boxes = running_boxes.reject{|w| redis_running_boxes.keys.include? w.instance_id }
      new_boxes.each do |box|
        debug "found box:#{box.instance_id}"
        redis.hset_hash "workers:running", box.instance_id, instance_id:box.instance_id, host:box.host, started_at:box.started_at
      end
      
      lost_world_ids = redis_running_worlds.keys - running_worlds.keys
      lost_world_ids.each do |world_id|
        debug "lost world:#{world_id}"
        redis.hdel "worlds:running", world_id
      end
      
      lost_busy_world_ids = redis_busy_worlds.keys - running_worlds.keys
      lost_busy_world_ids.each do |world_id|
        debug "lost busy world:#{world_id}"
        redis.hdel "worlds:busy", world_id
      end
      
      new_worlds = running_worlds.reject{|world_id, world| redis_running_worlds.keys.include? world_id }
      new_worlds.each do |world_id, world|
        debug "found world:#{world_id}"
        redis.hset_hash "worlds:running", world_id, instance_id:world['instance_id'], host:world['host'], port:world['port']
      end
      
      broken_boxes.each do |box|
        debug "fixing broken box:#{box.instance_id}"
        redis.lpush "workers:requests:fix", box.instance_id
      end

      running_boxes.each do |box|
        uptime_minutes = ((Time.now - box.started_at) / 60).to_i
        close_to_end_of_hour = uptime_minutes % 60 > 55
  
        world_count = running_worlds.count{|world_id, w| w['instance_id'] == box.instance_id }
      
        box_not_busy = redis_busy_boxes.count {|busy_box_id, world| busy_box_id == box.instance_id } == 0
       
        world_not_busy = redis_busy_worlds.count {|busy_world_id, data| data['instance_id'] == box.instance_id } == 0
  
        if close_to_end_of_hour and world_count == 0 and box_not_busy and world_not_busy
          puts "box:#{box.instance_id} terminating idle"
          redis.lpush "workers:requests:stop", box.instance_id
        end
      end
      @deferred_sweep.succeed
    end
    
  end
end