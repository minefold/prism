source :rubygems

gem 'god'
gem 'file-tail', :require => 'file/tail'
gem 'fog', git:'https://github.com/snappycode/fog'
gem 'httparty'
gem 'mongo'
gem 'bson_ext'
gem 'looksee'
gem 'parallel'
gem 'eventmachine', '1.0.0.beta.3'

group :proxy do
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
  gem "virtualbox"
end

group :chatty do
  gem 'eventmachine-tail', '~> 0.6.1'
  gem 'em-http-request'
  gem 'pusher'
end

group :cli do
  gem 'hirb'
end