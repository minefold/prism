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
    def self.find_box_for_new_world universe
      # find a box with the least amount of world slots and the most player slots
      # this means we fill boxes with smaller worlds and (in theory) allow larger
      # worlds to grow larger still. This might be complete bullshit...

      candidates = universe.boxes[:running].map do |instance_id, box|
        instance_type = box["instance_type"]
        box[:player_slots] = INSTANCE_PLAYER_CAPACITY[instance_type] - box[:players].size
        box[:world_slots] = INSTANCE_WORLD_CAPACITY[instance_type] - box[:worlds].size
        box
      end.sort_by {|box| [box[:world_slots], -box[:player_slots]] }
      
      candidates_with_capacity = candidates.select do |box|
        box[:world_slots] > 0 && box[:player_slots] >= INSTANCE_PLAYER_BUFFER
      end
      
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
    
    def self.start_new_box instance_type
      request_id = `uuidgen`.strip
      Prism.redis.lpush_hash "workers:requests:create", request_id:request_id, instance_type:instance_type
    end
  end
end