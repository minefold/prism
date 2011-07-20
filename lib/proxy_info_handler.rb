require 'erb'

class ProxyInfoHandler  < EventMachine::Connection
  include EventMachine::HttpServer
 
  def process_http_request
    resp = EventMachine::DelegatedHttpResponse.new( self )
 
    operation = proc do
      begin
        template = ERB.new File.read "#{LIB}/proxy_info.html.erb"
      
        resp.status = 200
        resp.content = template.result(binding)
      rescue => e
        resp.status = 500
        resp.content = <<-EOS 
          <html><head><title>Error</title></head>
          <body><pre>#{e.message}\n#{e.backtrace.join("\n")}
          </pre></body></html>
          EOS
      end
    end
 
    callback = proc do |res|
    	resp.send_response
    end
 
    EM.defer operation, callback
  end
end