source :rubygems

gem 'god'
gem 'file-tail', :require => 'file/tail'
gem 'fog', '>= 0.9.0'

group :proxy do
  gem 'eventmachine'
  gem 'mongo'
  gem 'bson_ext'
  gem 'eventmachine_httpserver', :require => 'evma_httpserver'
end

group :worker do
  gem 'sinatra'
  gem 'sinatra-reloader', :require => 'sinatra/reloader'
  gem 'unicorn'
end

group :test do
  gem 'rspec', '~> 2.6.0'
  gem "ZenTest", "~> 4.4.2"
end