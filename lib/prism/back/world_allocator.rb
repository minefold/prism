require 'time'

module Prism
  PLAYER_RAM_SIZE = 128
  
  INSTANCE_PLAYER_CAPACITY = { 
    'm1.large'   => 50,
    'm2.xlarge'  => 130,
    'm2.2xlarge' => 260,
    'm2.4xlarge' => 530
  }.freeze
  
  INSTANCE_WORLD_CAPACITY = {
    'm1.large'   => 8,
    'm2.xlarge'  => 13,
    'm2.2xlarge' => 26,
    'm2.4xlarge' => 52
  }.freeze
  
  INSTANCE_PLAYER_BUFFER = 10 # needs to be space for 10 players to start a world
  INSTANCE_WORLD_BUFFER  = 1  # if the last box with capacity has space for 1 world, start a new box
  
  class WorldAllocator
    attr_reader :universe
    
    def initialize universe
      @universe = universe
    end
    
    def find_box_for_new_world
      # find a box with the least amount of world slots and the most player slots
      # this means we fill boxes with smaller worlds and (in theory) allow larger
      # worlds to grow larger still. This might be complete bullshit...
      
      boxes_with_capacity.each do |box|
        puts "candidate:#{box["instance_id"]}  world_slots:#{box[:world_slots]}  player_slots:#{box[:player_slots]}"
      end
      
      start_box_if_at_capacity
      
      boxes_with_capacity.any? ? boxes_with_capacity.first["instance_id"] : nil
    end
    
    def rebalance_boxes
      start_box_if_at_capacity
      shutdown_idle_boxes
    end
    
    def shutdown_idle_boxes
      # shutdown idle boxes when there is at least 1 other box with capacity
      number_of_idles_we_can_kill = boxes_with_capacity.size - 1
      
      idles_close_to_end_of_hour = idle_boxes.select{|instance_id, box| close_to_end_of_hour box }
      
      puts "boxes_with_capacity:#{boxes_with_capacity.size} idles:#{idle_boxes.size} killable:#{idles_close_to_end_of_hour.size}"
      if number_of_idles_we_can_kill > 0
        ids_to_kill = idles_close_to_end_of_hour.keys.take number_of_idles_we_can_kill
      
        ids_to_kill.each do |instance_id|
          box = idles_close_to_end_of_hour[instance_id]
        
          message = "box:#{box['instance_id']} worlds:#{box[:worlds].size} players:#{box[:players].size} uptime_minutes:#{uptime box}"
          puts "#{message} terminating idle"
          Prism.redis.lpush "workers:requests:stop", instance_id
        end
      end
    end
    
    def start_box_if_at_capacity
      start_new_box 'm1.large' if at_capacity?
    end
    
    def start_new_box instance_type
      request_id = `uuidgen`.strip
      Prism.redis.lpush_hash "workers:requests:create", request_id:request_id, instance_type:instance_type
    end
    
    def boxes_with_capacity
      @boxes_with_capacity ||= running_box_capacities.select {|box| has_capacity?(box) && accepting_worlds?(box) }
    end
    
    def idle_boxes
      @idle_boxes ||= begin
        non_busy_boxes.select do |instance_id, box|
          uptime_minutes = uptime box
          player_count = box[:players].size
           world_count = box[:worlds].size
          
          message = "box:#{instance_id} world_count:#{world_count} player_count:#{player_count} uptime:#{friendly_time uptime box}"
          message += " not accepting" unless accepting_worlds? box
          puts message
          
          player_count == 0 && world_count == 0
        end
      end
    end
    
    def non_busy_boxes
      universe.boxes[:running].reject{|id, box| universe.boxes[:busy].keys.include? id }
    end
    
    def running_box_capacities
      universe.boxes[:running].map do |instance_id, box|
        instance_type = box["instance_type"]
        box[:player_slots] = INSTANCE_PLAYER_CAPACITY[instance_type] - box[:players].size
        box[:world_slots] = INSTANCE_WORLD_CAPACITY[instance_type] - box[:worlds].size
        box
      end.sort_by {|box| [box[:world_slots], -box[:player_slots]] }
    end
    
    def at_capacity?
      # we're at capacity if there's no boxes left with capacity or the last box only has 1 world slot left
      # (this allows everyone to have a fast connect because there should always be a world slot available)
      (boxes_with_capacity.size < 1) || 
      (boxes_with_capacity.size == 1 && boxes_with_capacity[0][:world_slots] <= INSTANCE_WORLD_BUFFER)
    end
    
    # helper
    
    def friendly_time minutes
      hours, mins = minutes / 60, minutes % 60
      "#{'%02i' % hours}:#{'%02i' % mins}"
    end
    
    # box methods (encapsulate?)

    def has_capacity? box
      box[:world_slots] > 0 && box[:player_slots] >= INSTANCE_PLAYER_BUFFER
    end
    
    def accepting_worlds? box
      true unless box["tags"] && box["tags"]["accepting_worlds"] == "false"
    end
    
    def uptime box
      ((Time.now - Time.parse(box["started_at"])) / 60).to_i
    end
    
    def close_to_end_of_hour box
      uptime(box) % 60 > 55
    end
  end
end