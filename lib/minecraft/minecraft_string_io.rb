module Minecraft
  class MinecraftStringIO < StringIO
    EASY_FIELDS = {
        byte: [1, "C"],
       short: [2, "n"],
         int: [4, "N"],
        long: [8, "Q"],
       float: [4, "g"],
      double: [8, "G"]
    }

    def read_field type
      if field = EASY_FIELDS[type]
        read(field[0]).unpack(field[1]).first
      else
        case type
        when :string
          read_string
        end
      end
    end

    def read_string
      length = read_field :short

      bytes = read(length * 2)
      bytes.force_encoding('UTF-16BE').encode('UTF-8')
    end
  end
end