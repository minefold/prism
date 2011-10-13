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
      universe.boxes[:running].each do |instance_id, box|
        player_capacity = box[:instance_type]
        player_count = box[:players].size
        world_count  = box[:worlds.size
        
        
      end
      
        EM::Iterator.new(boxes).inject({}, proc{ |hash, (instance_id, box), iter|
            instance_type = box['instance_type']
            player_capacity = INSTANCE_PLAYER_CAPACITY[instance_type]
            world_capacity  = INSTANCE_WORLD_CAPACITY[instance_type]
            
            op = redis.smembers "workers:#{instance_id}:worlds" 
            op.callback do |worlds|
              world_count = worlds.size
              world_sets = worlds.map {|world_id| "worlds:#{world_id}:connected_players"}
              if world_sets.any?
                
                op = redis.sunion world_sets
                op.callback do |connected_players|
                  puts "box:#{instance_id} world_count:#{world_count} player_count:#{connected_players.size} player_cap:#{player_capacity} world_cap:#{world_capacity} (#{instance_type})"
                  
                  if (player_capacity - connected_players.size > INSTANCE_PLAYER_BUFFER) # &&
                     # (world_capacity - world_count > 0)
                    hash[instance_id] = box
                  end
                  iter.return hash
                end
              else
                puts "box:#{instance_id} world_count:0 player_count:0 player_cap:#{player_capacity} world_cap:#{world_capacity} (#{instance_type})"
                hash[instance_id] = box
                iter.return hash
              end
            end
          }, proc { |workers_with_capacity|
            if workers_with_capacity.any?
              sorted_workers = workers_with_capacity.sort_by do |instance_id, w| 
                Time.now - Time.parse(w['started_at'])
              end
            
              instance_id = sorted_workers.first[0]
                        end
          })
      end
      
    end
  end
end