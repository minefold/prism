Dir[File.expand_path('../runpack/*.rb', __FILE__)].each { |f| require f }

module Widget
  module Runpack
    def self.serialize world_path, runpack
      File.write("#{world_path}/runpack.json", {
        name: runpack.class.name,
        options: runpack.options
      }.to_json)
    end
    
    def self.deserialize world_path, world_id, port
      json = JSON.parse File.read("#{world_path}/runpack.json")
      klass = json['name'].constantize
      klass.new(world_id, port, json['options'])
    end
    
    def self.create world_id, port, options
      "Widget::Runpack::#{options['name']}".constantize.new(world_id, port, options)
    end
  end
end
