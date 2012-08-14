module Prism
  module WorldCollector
    def initialize timeout, df
      @timeout = timeout
      @df = df
      @started_at = Time.now
    end

    def post_init
      send_data "worlds"
    end

    def receive_data data
      @data ||= ""
      @data << data

      # TODO: this is here temporarily as currently widget won't hang up
      json_data = JSON.parse @data rescue nil
      if json_data
        @delta = (Time.now - @started_at)
        close_connection
      end
    end

    def unbind
      @timeout.cancel
      if @data
        @df.succeed JSON.parse(@data), @delta
      else
        @df.fail
      end
    end
  end


  module Box
    def self.box_class
      case Fold.workers
      when :local
        Local
      when :cloud
        Cloud
      end
    end

    def self.all *c, &b
      box_class.all *c, &b
    end

    def self.find *c, &b
      box_class.find *c, &b
    end

    def self.create options = {}
      box_class.create options
    end

    class Base
      attr_reader :instance_id, :instance_type, :host, :started_at, :tags

      def uptime
        ((Time.now - started_at) / 60).to_i
      end

      def query_worlds timeout = 20
        df = EM::DefaultDeferrable.new
        
        @timeout = EM.add_periodic_timer(timeout) do
          puts "timeout querying worlds instance_id:#{instance_id} host:#{host}"
          df.fail "timeout"
        end

        begin
          c = EM.connect host, 3000, WorldCollector, @timeout, df
          c.pending_connect_timeout = 2
        rescue => e
          df.fail e
        end
        df
      end

      def to_hash
        {
            instance_id:instance_id,
                   host:host,
             started_at:started_at,
          instance_type:instance_type,
                   tags:tags
        }
      end
    end

  end
end