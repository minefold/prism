$:.unshift File.join File.dirname(__FILE__), 'lib'
require 'rake/clean'

CLEAN.add 'tmp'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  t.pattern = 'spec/**/*_spec.rb'
end

require 'resque'
require 'resque/tasks'

task "resque:setup" do
  require 'mongo'
  require 'httparty'
  require 'minefold'
  require 'jobs'
  require 'fog'

  if ENV["REDISTOGO_URL"]
    uri = URI.parse(ENV["REDISTOGO_URL"])
    Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  end
end

