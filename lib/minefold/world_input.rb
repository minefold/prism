module Minefold
  module WorldInput
    def send_world_message world_id, message
      append_world_stdin world_id, "say #{message}"
    end

    def send_player_message world_id, username, message
      append_world_stdin world_id, "tell #{username} #{message}"
    end
    
    private
    
    def append_world_stdin world_id, line
      File.open("#{WORLDS}/#{world_id}/world.stdin", "a") {|f| f.puts line }
    end
    
  end
end