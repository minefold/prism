class World
  attr_reader :name, :port
  attr_accessor :worker
  
  def initialize name, port
    @name, @port = name, port
  end
  
  def server_properties
    { "level-name"     => name,
      "hellworld"      => false,
      "spawn-monsters" => false,
      "online-mode"    => true,
      "spawn-animals"  => true,
      "max-players"    => 64,
      "server-ip"      => "0.0.0.0",
      "pvp"            => true,
      "level-seed"     => '',
      "server-port"    => port,
      "allow-flight"   => false,
      "white-list"     => false
    }.map {|values| values.join('=')}.join("\n")
  end
  
  def path
    "#{WORLDS}/#{name}"
  end
  
  def god_path
    "#{path}/world.god"
  end
  
end