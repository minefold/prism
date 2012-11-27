module Prism
  module Client
    extend Logging

    attr_reader :handler, :buffered_data

    def post_init
      @buffered_data = ""
      if File.exists?("tmp/maintenance")
        set_handler MaintenanceHandler, File.read("tmp/maintenance")
      else
        set_handler UnknownConnectionHandler
      end
    end

    def set_handler klass, *args
      # debug "handler > #{klass} #{args.join(', ')}"

      @handler = klass.new self, *args
      handler.change_handler { |klass, *args| set_handler klass, *args }
    end

    def receive_data data
      handler.receive_data data
    end

    def unbind
      handler.unbind
    end
  end
end
