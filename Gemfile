source :rubygems

gem 'god'
gem 'file-tail', :require => 'file/tail'
gem 'fog', '>= 0.9.0'

group :proxy do
  gem 'eventmachine'
  gem 'mongo'
  gem 'bson_ext'
end

group :worker do
  gem 'sinatra'
  gem 'unicorn'
end

group :development do
  gem 'sinatra-reloader', :require => 'sinatra/reloader'
end