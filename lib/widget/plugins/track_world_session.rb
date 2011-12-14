require 'set'

module Widget
  class TrackWorldSession < WorldPlugin
    include Mixpanel::EventTracker
    
    MIN_GAME_SESSION = 120
    
    def all_players
      @all_players ||= Set.new
    end
    
    def world_started
      @started_at = Time.now
    end
    
    def players_listed usernames
      all_players.merge usernames
    end
    
    def player_connected username
      all_players.add username
    end
    
    def remote_ip; 1; end
    
    def world_stopped
      @mp_id = world_id.to_s
      seconds = (Time.now - @started_at).to_i
      if seconds > MIN_GAME_SESSION
        mixpanel_track 'game played', 'game' => 'Minecraft', 
                                   'minutes' => (seconds / 60), 
                                     'hours' => (seconds / 60 / 60),
                               'max players' => all_players.size
      end
    end
  end
end
