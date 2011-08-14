require 'socket'
require 'yaml'

class Statsd
  def self.timing bucket, milliseconds
    Statsd.send_data bucket, milliseconds, 'ms'
  end

  def self.count bucket, increment, sample_rate = 1 
    Statsd.send_data bucket, increment, 'c', sample_rate
  end

  def self.raw bucket, value
    Statsd.send_data bucket, value, 'r'
  end
  
  def self.send_data bucket, value, metric, sample_rate = 1
    sampling = sample_rate != 1 ? "|@#{sample_rate}" : ""
    packet = "#{bucket}:#{value}|#{metric}#{sampling}"
    begin
      udp = UDPSocket.new
      udp.send packet, 0, host, port
    rescue => e
      puts e.message
    end
  end
  
  def self.host
    config["host"] || "localhost"
  end
  
  def self.port
    config["port"] || "8125"
  end

  def self.config
    @@config ||= begin 
      config_path = File.join(Fold.root, "config", "statsd.yml")
      @@config = open(config_path) { |f| YAML.load(f) }
      @@config = @@config[Fold.env.to_s]
    rescue => e
      puts "config: #{e.message}"
      @@config = {}
    end
  end
end