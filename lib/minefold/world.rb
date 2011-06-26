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
  
  def god_running?
    `bundle exec god status`
    $?.exitstatus == 0
  end

  def god_load_config config_file
    if god_running?
      `bundle exec god load #{config_file}`
    else
      `bundle exec god -c #{config_file}`
    end
  end
  
  def start
    god_load_config god_path
    `bundle exec god start minecraft-#{name}`
  end
  
  def path
    "#{WORLDS}/#{name}"
  end
  
  def god_path
    "#{path}/world.god"
  end
  
end