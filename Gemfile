source :rubygems

gem 'god'
gem 'file-tail', :require => 'file/tail'
gem 'fog', ">= 0.9.0"

group :proxy do
  gem 'eventmachine' #, '>= 1.0.0.beta.3'
end

group :worker do
  gem 'sinatra'
  gem 'unicorn'
end

group :development do
  gem 'sinatra-reloader', :require => 'sinatra/reloader'
end