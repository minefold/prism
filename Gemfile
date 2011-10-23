source :rubygems

gem 'god', git:'https://github.com/whatupdave/god'
gem 'file-tail', :require => 'file/tail'
gem 'fog', git:'https://github.com/whatupdave/fog'
gem 'httparty'
gem 'mongo'
gem 'bson_ext'
gem 'looksee'
gem 'parallel'
gem 'eventmachine', '1.0.0.beta.3'
gem 'eventmachine-tail'
gem 'rake'
gem "hiredis", "~> 0.3.1"
gem "redis", "~> 2.2.0", :require => ["redis/connection/hiredis", "redis"]
gem 'em-hiredis', git:'https://github.com/whatupdave/em-hiredis'
gem 'resque'
gem 'resque-lock', require:'resque/plugins/lock'
gem "resque-loner"
gem "em-mongo"
gem 'hirb'
gem 'statsd-instrument', git:'https://github.com/Shopify/statsd-instrument.git'
gem 'pusher'

group :test do
  gem "autotest-fsevent"
  gem "autotest-growl"
  gem 'foreman'
  gem 'launchy'
  gem 'rr', '~> 1.0.3'
  gem 'rspec', '~> 2.6.0'
  gem 'simplecov', '>= 0.4.0', :require => false
  gem 'spork', '~> 0.9.0.rc'
  gem 'timecop', '~> 0.3.5'
  gem "virtualbox"
  gem "ZenTest", "~> 4.4.2"
  gem 'em-spec', git:'https://github.com/joshbuddy/em-spec.git', require:'em-spec/rspec'
  gem 'awesome_print'
end

group :geo do
  gem 'geokit' # warning requires json/pure which kills everything
end
