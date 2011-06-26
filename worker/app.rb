
get "/" do
  content_type :json
  Worlds.running.to_json
end

# TODO: make this stuff restful
get "/worlds/create" do
  content_type :json
  `#{BIN}/start-world #{params[:id]}`
  redirect "/"
end

get "/worlds/:id" do
  content_type :json
  Worlds.running.find{|w| w[:name] == params[:id] }.to_json
end

get "/worlds/:id/destroy" do
  content_type :json
  `#{BIN}/stop-world #{params[:id]}`
  redirect "/"
end

