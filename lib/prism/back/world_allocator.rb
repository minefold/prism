require 'time'

module Prism
  ECUS_PER_WORLD = 1.5
  RAM_PER_PLAYER = 128
  OS_RAM_BUFFER = 0.1 # let the OS have this much ram

  INSTANCE_PLAYER_BUFFER = 5 # needs to be space for 5 players to start a world on a box
  WORLD_BUFFER = 3  # there must be room for 3 more worlds at any time

  AMIS = {
    '64bit' => 'ami-9ed905f7',
      'HVM' => 'ami-844b98ed'
  }

  INSTANCE_DEFS = {
    'm1.small'    => { ram:  1.7 * 1024, ecus:  1.0, image_id: AMIS['64bit'] },   # worlds:  1  players:  14
    'm1.large'    => { ram:  7.5 * 1024, ecus:  4.0, image_id: AMIS['64bit'] },   # worlds:  3  players:  60
    'm1.xlarge'   => { ram: 15.0 * 1024, ecus:  8.0, image_id: AMIS['64bit'] },   # worlds:  5  players:  120

    'm2.xlarge'   => { ram: 17.1 * 1024, ecus:  6.5, image_id: AMIS['64bit'] },   # worlds:  4  players: 137
    'm2.2xlarge'  => { ram: 34.2 * 1024, ecus: 13.0, image_id: AMIS['64bit'] },   # worlds:  9  players: 274
    'm2.4xlarge'  => { ram: 68.4 * 1024, ecus: 26.0, image_id: AMIS['64bit'] },   # worlds: 17  players: 547

    'cc1.4xlarge' => { ram: 23.0 * 1024, ecus: 33.5, image_id: AMIS['64bit'] },   # worlds: 22  players:  184
    'cc2.8xlarge' => { ram: 60.5 * 1024, ecus: 88.0, image_id: AMIS['64bit'] }    # worlds: 59  players:  484
  }.freeze

  class BoxType
    attr_reader :instance_type, :instance_ram, :player_cap, :world_cap, :image_id, :ram_slot, :players_per_slot

    def initialize instance_type
      @instance_type = instance_type
      instance = INSTANCE_DEFS[instance_type]
      @image_id         = instance[:image_id]

      @instance_ram     = instance[:ram] * (1 - OS_RAM_BUFFER)        # 6451 Mb
      @world_cap        = (instance[:ecus] / ECUS_PER_WORLD).round    # 13
      @player_cap       = (@instance_ram / RAM_PER_PLAYER).round      # 50
      @ram_slot         = (@instance_ram / world_cap).round           # 496
      @players_per_slot = (@player_cap / @world_cap)                  # 4
    end

    def to_hash
      {
        instance_type: instance_type,
             image_id: image_id
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
      'c1.xlarge'
    end

    def start_options_for_new_world world, slots_required = nil
      # find a box with the least amount of world slots and the most player slots
      # this means we fill boxes with smaller worlds and (in theory) allow larger
      # worlds to grow larger still. This might be complete bullshit…

      # TODO: calculate this from player counts
      slots_required ||= 1

      # TODO: this probably belongs in the sweeper (rebalancer)
      start_box_if_at_capacity

      if box = find_box_for_new_world(world, slots_required)
        box_type = BoxType.new(box['instance_type'])
        start_options = box_type.to_hash.merge({
          instance_id: box['instance_id'],
          heap_size: slots_required * box_type.ram_slot,
          slots: slots_required
        })
      end
    end

    def find_box_for_new_world world, slots_required
      # check if there's a specific box to send this world
      if box = running_box_capacities.find{|box| Array(worlds_accepted(box)).include? world['_id'] }
        puts "using dedicated box:#{box['instance_id']}"
        box

      else
        candidates = boxes_with_capacity.select do |box|
          puts "candidate:#{box["instance_id"]}  world_slots:#{box[:world_slots]}  player_slots:#{box[:player_slots]}"
          box[:world_slots] >= slots_required
        end

        candidates.first if candidates.any?
      end
    end

    def rebalance
      print_box_status
      start_box_if_at_capacity
      shutdown_idle_boxes
      shutdown_boxes_not_in_use
    end

    def shutdown_idle_boxes
      excess_capacity = total_world_slots - WORLD_BUFFER

      idles_close_to_end_of_hour = idle_boxes.select{|instance_id, box| close_to_end_of_hour box }

      puts "available world slots:#{total_world_slots} idle boxes:#{idle_boxes.size} killable:#{idles_close_to_end_of_hour.size}"

      idles_close_to_end_of_hour.each do |instance_id, box|
        box_type = BoxType.new(box['instance_type'])
        excess_capacity -= box_type.world_cap
        if excess_capacity >= 0
          box = idles_close_to_end_of_hour[instance_id]

          message = box[:description]
          puts "#{message} terminating idle"
          Prism.redis.lpush "workers:requests:stop", instance_id
        end
      end
    end

    def shutdown_boxes_not_in_use
      unusable_boxes.select {|box| box[:worlds].size == 0 && box[:players].size == 0 && close_to_end_of_hour(box) }.each do |box|
        message = box[:description]
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
        box_type = BoxType.new(box['instance_type'])
        puts "box:#{request_id} slots:#{box_type.world_cap} players:#{box_type.player_cap} creating..."
      end

      running_box_capacities.each do |box|
        box_type = BoxType.new(box['instance_type'])
        widget = universe.widgets[box['instance_id']]

        if widget
          if box[:worlds].any?
            worlds_info = box[:worlds].each_with_object({}) do |(id, w), h|
              h[id] = {
                players: w[:players].size,
                cpu: 0,
                mem: 0
              }

              if pi = widget['pi'] and widget['pi'][id]
                h[id][:cpu] = pi[id]['cpu'].to_i
                h[id][:mem] = pi[id]['mem'].to_i * 1024
              end
            end

            # worlds:[4 13% 292Mb]
            descriptions = worlds_info.values.map {|w| "[#{w[:players]} #{w[:cpu]}% #{w[:mem].to_human_size}]" }
            player_total = worlds_info.values.inject(0) {|sum, w| sum + w[:players] }
            cpu_total = worlds_info.values.inject(0) {|sum, w| sum + w[:cpu] }
            mem_total = worlds_info.values.inject(0) {|sum, w| sum + w[:mem] }
            puts "box:#{box['instance_id']} worlds:#{descriptions.join(' ')} total:[#{player_total} #{cpu_total}% #{mem_total.to_human_size}]"
          end

          if disk = widget['disk']
            puts "box:#{box['instance_id']} disk: #{disk.values.map{|d| ((d['used'] / (d['total'] || 1).to_f) * 100).to_i.to_s + "%" }.join(' ')}"
          end
        end

        message = box[:description]
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
          box[:world_slots] = box_type.world_cap - box[:worlds].inject(0) {|sum, (id, w)| sum + (w['slots'] || 1)}
          box[:description] = {
            box: instance_id,
            worlds: box[:worlds].size,
            slots: "#{box_type.world_cap - box[:world_slots]}/#{box_type.world_cap}",
            uptime: friendly_time(uptime box)
          }.map{|k,v| "#{k}:#{v}" }.join(' ')

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
      total_world_slots < WORLD_BUFFER
    end

    # 4 players per slot on c1.xlarge
    #    1    2    4      8
    #   0-4  4-8  8-16  16-32

    # 24 players per slot on m1.xlarge
    #    1      2      4
    #   0-24  24-48  48-96


    def world_allocations
      universe.worlds[:running].map do |world_id, world|
        box_type = BoxType.new(world[:box]['instance_type'])
        current_slots = world['slots']

        # this might leave us between a power of 2 slot like
        # if it's 6 we want 8, if it's 8 we want 8, if it's 9 we want 16
        required_slots = (world[:players].size / box_type.players_per_slot.to_f).ceil
        required_slots = 1 if required_slots == 0

        # so clamp it!
        clamped_required_slots = 2**(Math.log(required_slots,2).floor)

        {
          world_id: world_id,
          current_slots: current_slots,
          required_slots: clamped_required_slots
        }
      end
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