module Minecraft
  class MinecraftPacket
    def initialize header, body = {}
      @definition = {
        :header => :byte
      }.merge(body)
    end

    def parse data
      values = {}
      MinecraftStringIO.open(data) do |io|
        @definition.each do |name, type|
          values[name] = io.read_field type
        end
      end
      values
    end
  end
end