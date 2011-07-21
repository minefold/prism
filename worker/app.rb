
get "/" do
  content_type :json
  LocalWorlds.running.to_json
end

# TODO: make this stuff restful
post "/worlds" do
  result = `#{BIN}/start-local-world #{params[:id]}`
  if $?.exitstatus != 0
    puts result
    raise result
  else
    redirect "/"
  end
end

get "/worlds/:id" do
  content_type :json
  LocalWorlds.running.find{|w| w[:id] == params[:id] }.to_json
end

post "/worlds/:id/destroy" do
  content_type :json
  result = `#{BIN}/stop-local-world #{params[:id]}`
  if $?.exitstatus != 0
    puts result
    raise result
  else
    redirect "/"
  end
end

