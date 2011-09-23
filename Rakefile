require 'bundler/setup'
Bundler.require :default
require 'rake'
require 'rake/clean'

CLEAN.add 'tmp'

$:.unshift File.join File.dirname(__FILE__), 'lib'
require 'minefold'
Dir[File.expand_path('../lib/tasks/*.rb', __FILE__)].each { |f| require f }

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

def redis_connect
  uri = URI.parse(ENV['REDISTOGO_URL'] || REDISTOGO_URL)
  Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

require 'resque'
require 'resque/tasks'

task "resque:setup" do
  require 'bundler/setup'
  Bundler.require :default, :chatty
  require 'minefold'

  if REDISTOGO_URL
    Resque.redis = redis_connect
  end
end

task "map_world" => "resque:setup" do 
  require 'jobs'
  Resque.enqueue(Job::MapWorld, ENV['WORLD_ID'])
end

namespace :prism do
  task :deploy do
    puts `ssh -i .ssh/minefold.pem ubuntu@pluto.minefold.com "cd ~/minefold && GIT_SSH=~/deploy-ssh-wrapper git pull origin master && bundle --binstubs --without test chatty cli worker && sudo bin/god load conf/prism.god && sudo bin/god restart prism_back"`
  end
end

namespace :graphite do
  desc "Deploy the graphite dashboard.conf"
  task :dashboard do
    `scp -i .ssh/minefold.pem conf/graphite/dashboard.conf ubuntu@pluto.minefold.com:/opt/graphite/conf/dashboard.conf`
  end
end