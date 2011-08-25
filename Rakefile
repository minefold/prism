require 'bundler/setup'
Bundler

$:.unshift File.join File.dirname(__FILE__), 'lib'
require 'rake'
require 'rake/clean'

CLEAN.add 'tmp'

# RSpec
begin
  require "rspec/core/rake_task"
  require 'launchy'
  
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/**/*_spec.rb'
    t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  end
  
  desc "Run tests with coverage"
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task["spec"].execute
    Launchy.open("file://" + File.expand_path("../coverage/index.html", __FILE__))
  end
rescue LoadError
  # no rspec
end

task "redis:state" do
  redis = Redis.new
  ["players:playing",
   "prism:active_connections",
   "worlds:running", "worlds:busy",
   "workers:running", "workers:busy"].each do |hash|
     puts hash
     p redis.hgetall(hash)
     puts
  end
  
  ["players:minute_played", "players:requesting_connection", "players:disconnecting"].each do |list|
    length = redis.llen list
    puts list
    p redis.lrange(list, 0, length)
    puts
  end
end

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