module MinecraftPackets
  def self.easy_fields
    { byte:[1, "C"], short:[2, "n"], int:[4, "N"], long:[8, "Q"], float:[4, "g"], double:[8, "G"] }
  end
  
  def self.pack_field type, value
    byte_size, code = easy_fields[type]
    if code
      [value].pack code
    else
      case type
      when :string8
        [value.length, value.encode('UTF-8')].pack("na*")
      when :string16
        [value.length, value.encode('UTF-16BE')].pack("na*")
      when :bool
        [value ? 0 : 1].pack("C")
      else
        raise "Unknown field type #{type}"
      end
    end
  end
  
  def self.read_field type, packet, index
    byte_size, code = easy_fields[type]
    if code
      [packet[index..(index + byte_size)].unpack(code)[0], byte_size]
    else
      case type
      when :string8
        str_char_length, bytes_read = read_field :short, packet, index; index += bytes_read
        str_byte_length = (str_char_length)
        raw = packet[index..(index + str_byte_length)]
        value = raw.force_encoding('UTF-8').encode('UTF-8')
        [value, 2 + str_byte_length]
      when :string16
        str_char_length, bytes_read = read_field :short, packet, index; index += bytes_read
        str_byte_length = (str_char_length * 2)
        raw = packet[index..(index + str_byte_length - 1)]
        value = raw.force_encoding('UTF-16BE').encode('UTF-8')
        
        [value, 2 + str_byte_length]
      when :bool
        value, bytes_read = read_field(:byte, packet, index); index += bytes_read
        [value == 1, bytes_read]
      when :metadata
        value = 0x00
        while value != 0x7f
          
        end
      else
        raise "Unknown field type #{type}"
      end
    end
  end
  
  def self.create_packet schema, header, values
    data = pack_field(:byte, header)
    schema.each{|name, type| 
      raise "no value provided for #{name}" unless values[name]
      data << pack_field(type, values[name]) 
    }
    data
  end
  
  def self.create_client header, values = {}
    create_packet @@client_schemas[header], header, values
  end

  def self.create_server header, values = {}
    create_packet @@server_schemas[header], header, values
  end
  
  def self.parse_client packet
    # null if packet not long enough otherwise the parsed info plus the rest of the packet
    i = 0
    header, bytes_read = read_field :byte, packet, i; i += bytes_read
    
    schema = @@client_schemas[header]
    
    raise "Unknown packet:#{hex(header)}" unless schema

    body = schema.inject({}) do |hash, (name, type)|
      value, bytes_read = read_field type, packet, i
      i += bytes_read
      hash[name] = value
      hash
    end
    
    [header, body, packet[0...i], packet[i..-1]]
  end
  
  def self.parse_server packet
    # null if packet not long enough otherwise the parsed info plus the rest of the packet
    i = 0
    header, bytes_read = read_field :byte, packet, i; i += bytes_read
    
    schema = @@server_schemas[header]
    
    raise "Unknown packet:#{hex(header)}" unless schema

    body = schema.inject({}) do |hash, (name, type)|
      value, bytes_read = read_field type, packet, i; i += bytes_read
      hash[name] = value
      hash
    end

    [header, body, packet[0...i], packet[i..-1]]
  end
  
  def self.client header, schema = {}
    @@client_schemas ||= {}
    @@client_schemas[header] = schema
  end
  
  def self.server header, schema = {}
    @@server_schemas ||= {}
    @@server_schemas[header] = schema
  end
  
  # these are the originators. ie. client sent a client packet, server sent a server packet
  server 0x00
  
  client 0x01, :protocol_version => :int, :username => :string16, :map_seed => :long, :dimension => :byte
  server 0x01, :entity_id => :int, :unknown => :string16, :map_seed => :long, :dimension => :byte
  
  client 0x02, :username => :string16
  server 0x02, :server_id => :string16
  
  server 0x04, :time => :long
  server 0x05, :entity_id => :int, :slot => :short, :item_id => :short, :unknown => :short
  server 0x06, :x => :int, :y => :int, :z => :int
  
  client 0x0A, :on_ground => :bool
  client 0x0B, :x => :double, :y => :double, :stance => :double, :z => :double, :on_ground => :bool
  client 0x0C, :yaw => :float, :pitch => :float, :on_ground => :bool
  client 0x0D, :x => :double, :y => :double, :stance => :double, :z => :double, :yaw => :float, :pitch => :float, :on_ground => :bool
  server 0x0D, :x => :double, :stance => :double, :y => :double, :z => :double, :yaw => :float, :pitch => :float, :on_ground => :bool

  # server 0x18, :entity_id => :int, :type => :byte, 
  
  server 0x32, :x => :int, :z => :int, :mode => :bool, :x => :int, :y => :int, :z => :int, :yaw => :byte, :pitch => :byte, :metadata => :metadata
end