
get "/" do
  "hello!"
end

get "/worlds" do
  content_type :json
  LocalWorlds.running.to_json
end

# TODO: make this stuff restful
get "/worlds/create" do
  result = ENV['FOLD_ENV']=Fold.env; `#{BIN}/start-local-world #{params[:id]} #{params[:min_heap_size]} #{params[:max_heap_size]}`
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

get "/worlds/:id/destroy" do
  content_type :json
  result = ENV['FOLD_ENV']=Fold.env; `#{BIN}/stop-local-world #{params[:id]}`
  if $?.exitstatus != 0
    puts result
    raise result
  else
    redirect "/"
  end
end

