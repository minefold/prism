class Worker
  attr_reader :server
  
  def initialize server
    @server = server
  end
  
  def instance_id
    server.id
  end
  
  def public_ip_address
    server.public_ip_address
  end
  
  def url
    "http://#{public_ip_address}:3000"
  end
  
  def worlds
    uri = URI.parse url
    res = Net::HTTP.start(uri.host, uri.port) {|http| http.get('/') }
    server_info = JSON.parse res.body
    Worlds.new self, server_info.map {|h| World.new h["name"], h["port"]}
  end
  
  def stop_world world_name
    uri = URI.parse url
    res = Net::HTTP.start(uri.host, uri.port) {|http| http.get("/worlds/#{world_name}/destroy") }
    res.body
  end
end