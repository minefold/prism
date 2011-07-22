source :rubygems

gem 'god'
gem 'file-tail', :require => 'file/tail'
gem 'fog', '>= 0.9.0'
gem 'httparty'
gem 'mongo'
gem 'bson_ext'
gem 'looksee'


group :proxy do
  gem 'eventmachine'
  gem 'eventmachine_httpserver', :require => 'evma_httpserver'
  gem 'resque'
end

group :worker do
  gem 'sinatra'
  gem 'sinatra-reloader', :require => 'sinatra/reloader'
  gem 'thin'
end

group :test do
  gem 'rspec', '~> 2.6.0'
  gem "ZenTest", "~> 4.4.2"
end

group :chatty do
  gem 'eventmachine'
  gem 'eventmachine-tail', '~> 0.6.1'
end

group :cli do
  gem 'hirb'
end