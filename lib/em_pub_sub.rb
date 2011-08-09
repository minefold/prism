class EMPubSub < EM::Connection
  def self.connect
    uri = URI.parse(REDISTOGO_URL)

    host = uri.host || 'localhost'
    port = (uri.port || 6379).to_i
    
    EM.connect host, port, self
  end

  def post_init
    uri = URI.parse(REDISTOGO_URL)
    @blocks = {}
    call_command "auth", uri.password if uri.password
  end
  
  def subscribe(*channels, &blk)
    channels.each { |c| @blocks[c.to_s] = blk }
    call_command('subscribe', *channels)
  end
  
  def publish(channel, msg)
    call_command('publish', channel, msg)
  end
  
  def unsubscribe
    call_command('unsubscribe')
  end
  
  def receive_data(data)
    # puts "< #{data}"
    
    buffer = StringIO.new(data)
    begin
      parts = read_response(buffer)
      if parts.is_a?(Array)
        ret = @blocks[parts[1]].call(parts)
        close_connection if ret === false
      end
    end while !buffer.eof?
  end
  
  private
  def read_response(buffer)
    type = buffer.read(1)
    case type
    when ':'
      buffer.gets.to_i
    when '*'
      size = buffer.gets.to_i
      parts = size.times.map { read_object(buffer) }
    when '+'
      # puts "OK"
    else
      # puts "unsupported response type: #{type}"
    end
  end
  
  def read_object(data)
    type = data.read(1)
    case type
    when ':' # integer
      data.gets.to_i
    when '$'
      size = data.gets
      str = data.read(size.to_i)
      data.read(2) # crlf
      str
    else
      raise "read for object of type #{type} not implemented"
    end
  end
  
  # only support multi-bulk
  def call_command(*args)
    command = "*#{args.size}\r\n"
    args.each { |a|
      command << "$#{a.to_s.size}\r\n"
      command << a.to_s
      command << "\r\n"
    }
    # puts "> #{command}"
    
    send_data command
  end
end