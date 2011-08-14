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

task "map_world" => "resque:setup" do
  require 'jobs'
  Resque.enqueue(Job::MapWorld, ENV['WORLD_ID'])
end

namespace :prism do
  task :deploy do
    puts `ssh -i .ssh/minefold.pem ubuntu@pluto.minefold.com "cd ~/minefold && GIT_SSH=~/deploy-ssh-wrapper git pull origin master && bundle --binstubs --deployment --without test:chatty:worker && sudo bin/god restart proxy"`
  end
end

namespace :graphite do
  desc "Deploy the graphite dashboard.conf"
  task :dashboard do
    `scp -i .ssh/minefold.pem conf/graphite/dashboard.conf ubuntu@pluto.minefold.com:/opt/graphite/conf/dashboard.conf`
  end
end