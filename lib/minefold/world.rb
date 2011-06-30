class World
  attr_reader :id, :port
  attr_accessor :worker

  # TODO: Redesign interface. Options should really be loaded from Mongo
  #       (after being set in the web interface).
  def initialize id, port, opts={}
    @id, @port, @options = id, port, opts
  end

  def server_properties
    { "level-name"     => id,
      "hellworld"      => false,
      "spawn-monsters" => false,
      "online-mode"    => true,
      "spawn-animals"  => true,
      "max-players"    => 64,
      "server-ip"      => '0.0.0.0',
      "pvp"            => true,
      "level-seed"     => '',
      "server-port"    => port,
      "allow-flight"   => false,
      "white-list"     => false
    }.merge(@options).
      map {|values| values.join('=')}.
      join("\n")
  end

  def god_running?
    system "bundle exec god status"
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
    # TODO: Extract "minecraft-#{id}"
    `bundle exec god start minecraft-#{id}`
  end

  def path
    "#{WORLDS}/#{id}"
  end

  def god_path
    "#{path}/world.god"
  end

end