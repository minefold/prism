$:.unshift File.join File.dirname(__FILE__), 'lib'
require 'rake/clean'

CLEAN.add 'tmp'

# begin
#   require 'rspec/core/rake_task'
#   RSpec::Core::RakeTask.new do |t|
#     t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
#     t.pattern = 'spec/**/*_spec.rb'
#   end
# rescue
# end

require 'resque'
require 'resque/tasks'

task "resque:setup" do
  require 'bundler/setup'
  Bundler.require :default, :chatty
  require 'minefold'

  if REDISTOGO_URL
    uri = URI.parse(REDISTOGO_URL)
    Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  end
end

task "map_world" do
  require 'jobs'
  Resque.enqueue(Job::MapWorld, ENV['WORLD_ID'])
end

