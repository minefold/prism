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
    'm1.large'   => 6,
    'm2.xlarge'  => 7,
    'm2.2xlarge' => 14,
    'm2.4xlarge' => 27
  }.freeze
  
  INSTANCE_PLAYER_BUFFER = 10 # needs to be space for 10 players to start a world
  
  class WorldAllocator
    attr_reader :universe
    
    def initialize universe
      @universe = universe
    end
    
    def find_box_for_new_world
      # find a box with the least amount of world slots and the most player slots
      # this means we fill boxes with smaller worlds and (in theory) allow larger
      # worlds to grow larger still. This might be complete bullshit...
      candidates_with_capacity = boxes_with_capacity
      
      if candidates_with_capacity.size == 1
        # we're down to 1 box, if it only has 1 world slot left lets start a new box
        # in case more peeps join
        start_new_box 'm1.large' if candidates_with_capacity.first[:world_slots] == 1
      end
      
      candidates_with_capacity.each do |box|
        puts "candidate:#{box["instance_id"]}  world_slots:#{box[:world_slots]}  player_slots:#{box[:player_slots]}"
      end

      candidates_with_capacity.any? ? candidates_with_capacity.first["instance_id"] : nil
    end
    
    def shutdown_idle_boxes
      # shutdown idle boxes when there is at least 1 other box with capacity
      number_of_idles_we_can_kill = boxes_with_capacity.size - 1
      
      if number_of_idles_we_can_kill > 1
        candidates = idle_boxes
        ids_to_kill = candidates.keys.take number_of_idles_we_can_kill
      
        ids_to_kill.each do |instance_id|
          box = candidates[instance_id]
        
          message = "box:#{box['instance_id']} worlds:#{box[:worlds].size} players:#{box[:players].size} uptime_minutes:#{uptime box}"
          puts "#{message} terminating idle"
          Prism.redis.lpush "workers:requests:stop", instance_id
        end
      end
    end
    
    def start_new_box instance_type
      request_id = `uuidgen`.strip
      Prism.redis.lpush_hash "workers:requests:create", request_id:request_id, instance_type:instance_type
    end
    
    def boxes_with_capacity
      running_box_capacities.select {|box| box_has_capacity? box }
    end
    
    def idle_boxes
      non_busy_boxes.select do |instance_id, box|
        uptime_minutes = uptime box
        close_to_end_of_hour = uptime_minutes % 60 > 55
        
        player_count = box[:players].size
        world_count = box[:worlds].size
        
        close_to_end_of_hour && player_count == 0 && world_count == 0
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

    def box_has_capacity? box
      box[:world_slots] > 0 && box[:player_slots] >= INSTANCE_PLAYER_BUFFER
    end
    
    def uptime box
      ((Time.now - Time.parse(box["started_at"])) / 60).to_i
    end
  end
end