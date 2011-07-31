set :show_exceptions, false

get "/" do
  "hello!"
end

get "/worlds" do
  content_type :json
  LocalWorld.running.map(&:to_hash).to_json
end

# TODO: make this stuff restful
get "/worlds/create" do
  content_type :json
  world = LocalWorld.start params[:id], params[:min_heap_size], params[:max_heap_size]
  world.to_json
end

def find_world id
  world = LocalWorld.find params[:id]
  raise Sinatra::NotFound unless world
  world
end

get "/worlds/:id" do
  content_type :json
  find_world(params[:id]).to_json
end

get "/worlds/:id/destroy" do
  content_type :json
  world = find_world(params[:id])
  world.stop!
  world.to_json
end

error 404 do
  "404 Not found"
end

error 500 do
  "500 Error"
end

