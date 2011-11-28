require 'time'

module Prism
  ECUS_PER_WORLD = 2
  RAM_PER_PLAYER = 128
  INSTANCE_PLAYER_BUFFER = 5 # needs to be space for this many players to start a world
  INSTANCE_WORLD_BUFFER  = 3  # there must be room for 3 more worlds at any time
  OS_RAM_BUFFER = 0.2 # let the OS have this much ram
  
  INSTANCE_DEFS = {
    'c1.medium'  => { ram:  1.7 * 1024, ecus:  5.0, image_id: 'ami-3f0ec156' },   # worlds:  3  players:  14
    'c1.xlarge'  => { ram:  7.0 * 1024, ecus: 20.0, image_id: 'ami-f964a890' },   # worlds: 10  players:  56
    'm1.large'   => { ram:  7.5 * 1024, ecus:  4.0, image_id: 'ami-f964a890' },   # worlds:  2  players:  60
    'm2.xlarge'  => { ram: 17.1 * 1024, ecus:  6.5, image_id: 'ami-f964a890' },   # worlds:  3  players: 137
    'm2.2xlarge' => { ram: 34.2 * 1024, ecus: 13.0, image_id: 'ami-f964a890' },   # worlds:  7  players: 274
    'm2.4xlarge' => { ram: 68.4 * 1024, ecus: 26.0, image_id: 'ami-f964a890' }    # worlds: 13  players: 547
  }.freeze
  
  class BoxType
    attr_reader :instance_type, :instance_ram, :player_cap, :world_cap, :heap_size, :image_id

    def initialize instance_type
      @instance_type = instance_type
      instance = INSTANCE_DEFS[instance_type]
      
      @instance_ram = instance[:ram] - OS_RAM_BUFFER
      @world_cap    = (instance[:ecus] / ECUS_PER_WORLD).round
      @image_id     = instance[:image_id]
      @player_cap   = (@instance_ram / RAM_PER_PLAYER).round
      @heap_size    = (@instance_ram / world_cap).round
    end
    
    def to_hash
      {
        instance_type: instance_type,
             image_id: image_id,
            heap_size: heap_size
      }
    end
  end
  
  class WorldAllocator
    attr_reader :universe
    
    def initialize universe
      @universe = universe
    end
    
    def new_instance_type
      # make the first one small, then the other ones bigger
      # boxes_with_capacity.size == 0 ? 'c1.medium' : 'c1.xlarge'
      'c1.medium'
    end
    
    def find_box_for_new_world world
      # find a box with the least amount of world slots and the most player slots
      # this means we fill boxes with smaller worlds and (in theory) allow larger
      # worlds to grow larger still. This might be complete bullshit...
      
      # check world['whitelisted_player_ids']
      start_options = BoxType.new(new_instance_type).to_hash
        
      if box = running_box_capacities.find{|box| Array(worlds_accepted(box)).include? world['_id'] }
        puts "using dedicated box:#{box['instance_id']}"
        start_options[:instance_id] = box['instance_id']
      else
        boxes_with_capacity.each do |box|
          puts "candidate:#{box["instance_id"]}  world_slots:#{box[:world_slots]}  player_slots:#{box[:player_slots]}"
        end
      
        start_box_if_at_capacity
        
        start_options[:instance_id] = boxes_with_capacity.first["instance_id"] if boxes_with_capacity.any?
      end
      
      start_options
    end
    
    def rebalance_boxes
      print_box_status
      start_box_if_at_capacity
      shutdown_idle_boxes
      shutdown_boxes_not_in_use
    end
    
    def shutdown_idle_boxes
      excess_capacity = total_world_slots - INSTANCE_WORLD_BUFFER
            
      idles_close_to_end_of_hour = idle_boxes.select{|instance_id, box| close_to_end_of_hour box }
      
      puts "available world slots:#{total_world_slots} idle boxes:#{idle_boxes.size} killable:#{idles_close_to_end_of_hour.size}"
      
      idles_close_to_end_of_hour.each do |instance_id, box|
        box_type = BoxType.new(box['instance_type'])
        excess_capacity -= box_type.world_cap
        if excess_capacity >= 0
          box = idles_close_to_end_of_hour[instance_id]
        
          message = "box:#{instance_id} worlds:#{box[:worlds].size}/#{box_type.world_cap} players:#{box[:players].size}/#{box_type.player_cap} uptime_minutes:#{uptime box}"
          puts "#{message} terminating idle"
          Prism.redis.lpush "workers:requests:stop", instance_id
        end
      end
    end
    
    def shutdown_boxes_not_in_use
      unusable_boxes.select {|box| box[:worlds].size == 0 && box[:players].size == 0 && close_to_end_of_hour(box) }.each do |box|
        message = "box:#{box['instance_id']} worlds:#{box[:worlds].size} players:#{box[:players].size} uptime_minutes:#{uptime box}"
        puts "#{message} terminating unuseable"
        Prism.redis.lpush "workers:requests:stop", box['instance_id']
      end
    end
    
    def start_box_if_at_capacity
      start_new_box BoxType.new new_instance_type if at_capacity?
    end
    
    def start_new_box box_type
      puts "starting new box"
      request_id = `uuidgen`.strip
      Prism.redis.lpush_hash "workers:requests:create", box_type.to_hash.merge(request_id:request_id)
    end
    
    def print_box_status
      upcoming_boxes.each do |request_id, box|
        box_type = BoxType.new(box['instance_id'])
        puts "box:#{request_id} worlds:0/#{box_type.world_cap} players:0/#{box_type.player_cap} creating..."
      end
      
      running_box_capacities.each do |box|
        box_type = BoxType.new(box['instance_type'])
        message = "box:#{box['instance_id']} worlds:#{box[:worlds].size}/#{box_type.world_cap} players:#{box[:players].size}/#{box_type.player_cap} uptime:#{friendly_time uptime box}"
        message += " not accepting" if worlds_accepted box
        puts message
      end
    end
    
    def boxes_with_capacity
      @boxes_with_capacity ||= running_box_capacities.select {|box| has_capacity?(box) }.reject{|box| worlds_accepted(box) }
    end
    
    def unusable_boxes
      @unusable_boxes ||= running_box_capacities.select {|box| worlds_accepted(box) }
    end
    
    def idle_boxes
      # boxes that have no players, no worlds and are accepting new worlds
      @idle_boxes ||= begin
        non_busy_boxes.select do |instance_id, box|
          uptime_minutes = uptime box
          player_count = box[:players].size
           world_count = box[:worlds].size
          
          player_count == 0 && world_count == 0 && !keepalive?(box)
        end
      end
    end
    
    def non_busy_boxes
      @non_busy_boxes ||= universe.boxes[:running].reject{|id, box| universe.boxes[:busy].keys.include? id }
    end
    
    def running_box_capacities
      @running_box_capacities ||= begin
        universe.boxes[:running].map do |instance_id, box|
          box_type = BoxType.new box["instance_type"]
          box[:player_slots] = box_type.player_cap - box[:players].size
          box[:world_slots] = box_type.world_cap - box[:worlds].size
          box
        end.sort_by {|box| [box[:world_slots], -box[:player_slots]] }
      end
    end
    
    def total_world_slots
      running_world_slots + upcoming_world_slots
    end
    
    def running_world_slots
      boxes_with_capacity.inject(0) {|acc, box| acc + box[:world_slots] }
    end
    
    def upcoming_world_slots
      upcoming_boxes.inject(0) {|acc, (_, box)| acc + BoxType.new(box['instance_type']).world_cap }
    end
    
    def upcoming_boxes
      universe.boxes[:busy].select {|instance_id, box| box['state'] == 'creating' }
    end
    
    def at_capacity?
      total_world_slots < INSTANCE_WORLD_BUFFER
    end
    
    # helpers
    
    def friendly_time minutes
      hours, mins = minutes / 60, minutes % 60
      "#{'%02i' % hours}:#{'%02i' % mins}"
    end
    
    # box methods (encapsulate?)

    def has_capacity? box
      box[:world_slots] > 0 && box[:player_slots] >= INSTANCE_PLAYER_BUFFER
    end
    
    # list of worlds this box accepts
    def worlds_accepted box
      (box["tags"] && box["tags"]["worlds_accepted"]) ? box["tags"]["worlds_accepted"].split(',') : nil
    end
    
    def keepalive? box
      box["tags"] && box["tags"]["keepalive"]
    end
    
    def uptime box
      ((Time.now - Time.parse(box["started_at"])) / 60).to_i
    end
    
    def close_to_end_of_hour box
      uptime(box) % 60 > 55
    end
  end
end