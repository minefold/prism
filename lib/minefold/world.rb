class World
  attr_reader :name, :port
  attr_accessor :worker
  
  def initialize name, port
    @name, @port = name, port
  end
  
  def server_properties
    { 
      "allow-flight"     => false,
      "allow-nether"     => true,
      "hellworld"        => false,
      "level-name"       => name,
      "level-seed"       => '',
      "max-players"      => 255,
      "motd"             => "Welcome to minefold.com!"
      "online-mode"      => true,
      "pvp"              => true,
      "server-ip"        => "0.0.0.0",
      "server-port"      => port,
      "spawn-animals"    => true,
      "spawn-monsters"   => false,
      "spawn-protection" => true,
      "view-distance"    => 10,
      "white-list"       => false
      
    }.map {|values| values.join('=')}.join("\n")
  end
  
  def path
    "#{WORLDS}/#{name}"
  end
  
  def god_path
    "#{path}/world.god"
  end
  
end