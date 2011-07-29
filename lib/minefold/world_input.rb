module Minefold
  module WorldInput
    def send_world_message world_id, message
      console_message world_id, "say #{message}"
    end

    def send_player_message world_id, username, message
      console_message world_id, "tell #{username} #{message}"
    end
    
    def console_message world_id, message
      File.open("#{WORLDS}/#{world_id}/world.stdin", "a") {|f| f.puts message }
    end
      
  end
end