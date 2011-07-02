class ProxyInfoHandler  < EventMachine::Connection
  include EventMachine::HttpServer
 
  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new( self )
 
    operation = proc do
      template = ERB.new File.read "#{LIB}/proxy_info.html.erb"
      
      resp.status = 200
      resp.content = template.result(binding)
    end
 
    callback = proc do |res|
    	resp.send_response
    end
 
    EM.defer operation, callback
  end
end