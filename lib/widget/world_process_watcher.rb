  module Widget
  class WorldProcessWatcher
    def self.poll pid, *args
      watcher = new *args
      yield watcher if block_given?
      poller = EM.add_periodic_timer(1) do
        unless Process.alive? pid
          poller.cancel
          watcher.unbind
        end
      end
    end
  
    include Resque::Helpers
    include Debugger
  
    attr_accessor :on_process_exit, :on_world_stopped, :on_players_listed, :on_player_connected, :on_player_disconnected
    
    attr_reader :runpack, :stdin, :stdout, :world_id, :instance_id, :host, :port, :redis, :stdin_queues, :stop_queues, :plugins
    
    def stop_queue
      stop_queues[world_id]
    end

    def stdin_queue
      stdin_queues["workers:#{instance_id}:worlds:#{world_id}:stdin"]
    end
  
    def initialize runpack, stdin, stdout, world_id, instance_id, host, port, stdin_queues, stop_queues
      @runpack = runpack
      @stdin, @stdout = stdin, stdout
      @world_id, @instance_id, @host, @port = world_id, instance_id, host, port
      @stdin_queues, @stop_queues = stdin_queues, stop_queues
      @redis = Prism.redis
      @plugins = WorldPlugin.plugins.map {|klass| klass.new world_id }
    
      process_stdin
      stop_queue.pop { stop_world }
    
      EM.add_timer(10) { send_line "list" }
      
      EM.file_tail(stdout, Widget::WorldLineReader, 0) do |reader| 
        reader.on_line = proc do |line|
          info ["mc", world_id, line.type], line.log_entry

          case line.type
          when :chat_message
            Resque.push('high', :class => 'ProcessChatJob', :args => [ world_id.to_s, line.chat_user, line.chat_message ])
          when :connected_players
            plugins.each {|p| p.players_listed line.players }
            on_players_listed.call line.players
          when :player_connected
            plugins.each {|p| p.player_connected line.user }
            on_player_connected.call line.user
          when :player_disconnected
            plugins.each {|p| p.player_disconnected line.user }
            on_player_disconnected.call line.user
          when :world_started
            redis.store_running_world instance_id, world_id, host, port
            plugins.each &:world_started
          when :op
            Resque.push 'low', class: 'PlayerOppedJob', args: [world_id, line.user]
          when :deop
            Resque.push 'low', class: 'PlayerDeoppedJob', args: [world_id, line.user]
          when :world_stressed
            StatsD.increment "boxes.#{instance_id}.worlds.#{world_id}.stressed"
          when :port_taken
            stop_world
          end
        end
      end
    end
  
    def stop_world
      StatsD.increment "boxes.#{instance_id}.worlds.#{world_id}.stopped"
      send_line "stop"
    end
  
    def send_line line
      runpack.send_line line
    end
  
    def unbind
      runpack.world_stopped do
        on_world_stopped.call 
        plugins.each &:world_backed_up
      end
      
      on_process_exit.call
      plugins.each &:world_stopped
    end
    
    def process_stdin
      stdin_queue.pop { |message| send_line message; EM.next_tick { process_stdin } }
    end
  end
end