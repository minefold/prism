source :rubygems

gem 'god', git:'https://github.com/snappycode/god'
gem 'file-tail', :require => 'file/tail'
gem 'fog', git:'https://github.com/snappycode/fog'
gem 'httparty'
gem 'mongo'
gem 'bson_ext'
gem 'looksee'
gem 'parallel'
gem 'eventmachine', '1.0.0.beta3'
gem 'rake'
gem "hiredis", "~> 0.3.1"
gem "redis", "~> 2.2.0", :require => ["redis/connection/hiredis", "redis"]
gem 'em-hiredis'
gem 'resque'
gem 'resque-lock', require:'resque/plugins/lock'
gem "resque-loner"
gem "em-mongo"

group :worker do
  gem 'sinatra'
  gem 'sinatra-reloader', :require => 'sinatra/reloader'
  gem 'thin'
end

group :test do
  gem 'foreman'
  gem 'rspec', '~> 2.6.0'
  gem 'rr', '~> 1.0.3'
  gem "ZenTest", "~> 4.4.2"
  gem "autotest-growl"
  gem "autotest-fsevent"
  gem "virtualbox"
  gem 'hirb'
  gem 'spork', '~> 0.9.0.rc'
  gem 'timecop', '~> 0.3.5'
  gem 'simplecov', '>= 0.4.0', :require => false
  gem 'launchy'
end

group :chatty do
  gem 'eventmachine-tail', '~> 0.6.1'
  gem 'pusher'
end
