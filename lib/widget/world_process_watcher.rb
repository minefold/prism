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
  
    attr_accessor :on_process_exit, :on_world_stopped
    attr_reader :stdin, :stdout, :world_id, :instance_id, :host, :port, :redis, :stdin_queues, :stop_queues
    
    def stop_queue
      stop_queues[world_id]
    end

    def stdin_queue
      stdin_queues["workers:#{instance_id}:worlds:#{world_id}:stdin"]
    end
  
    def initialize stdin, stdout, world_id, instance_id, host, port, stdin_queues, stop_queues
      @stdin, @stdout = stdin, stdout
      @world_id, @instance_id, @host, @port = world_id, instance_id, host, port
      @stdin_queues, @stop_queues = stdin_queues, stop_queues
      @redis = Prism.redis
    
      process_stdin
      stop_queue.pop { stop_world }
    
      EM.add_timer(10) { send_line "list" }
      @backup_timer = EM.add_periodic_timer(10 * 60) { backup_world }
         @map_timer = EM.add_periodic_timer(10 * 60) { Resque.enqueue Job::MapWorld, world_id }
    end
  
    def stop_world
      StatsD.increment "boxes.#{instance_id}.worlds.#{world_id}.stopped"
      send_line "stop"
    end
  
    def send_line line
      File.open(stdin, 'a') {|f| f.puts line }
    end
  
    def unbind
      @backup_timer.cancel if @backup_timer
      @map_timer.cancel if @map_timer
      on_process_exit.call
      
      @backup_waiter = EM.add_periodic_timer(10) do
        unless @backup_in_progress
          @backup_waiter.cancel
          EM.defer(proc { 
              begin
                Process.waitpid fork { LocalWorld.new(world_id).backup! }
              rescue => e
                info "ERROR: backup on world stop failed: #{e.message}\n#{e.backtrace}"
              end
            },
            proc { on_world_stopped.call })
        end 
      end
      
    end
  
    def backup_world
      @backup_in_progress = true
      info "starting backup"
      send_line "save-off"
      send_line "save-all"
      EM.add_timer 3 do
        EM.defer(
          proc { 
            begin
              StatsD.increment "boxes.#{instance_id}.worlds.#{world_id}.backup"
              Process.waitpid fork { LocalWorld.new(world_id).backup! }
            rescue => e
              info "ERROR: backup failed: #{e.message}\n#{e.backtrace}"
            end
            }, 
          proc { 
            send_line "save-on"
            @backup_in_progress = false
          })
      end
    end
  
    def process_stdin
      stdin_queue.pop { |message| send_line message; EM.next_tick { process_stdin } }
    end
  end
end