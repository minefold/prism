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

namespace :jobs do
  task :map_world => "resque:setup" do 
    require 'jobs'
    Resque.enqueue(Job::MapWorld, ENV['WORLD_ID'] || '4e7d843f9fe7af003e000001')
  end
  
  task :world_started => "resque:setup" do
    Resque.push 'low', class: 'WorldStartedJob', args: [ENV['WORLD_ID'] || '4e7d843f9fe7af003e000001']
  end
end

desc "store latest server"
task :store_server do
  `curl -L https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft_server.jar -o tmp/server.jar`
end

namespace :prism do
  def ssh cmd
    puts `ssh -i #{ENV['EC2_SSH']} ubuntu@#{ENV['HOST']} "#{cmd}"`
  end
  
  task :deploy do
    ssh "cd /opt/prism && sudo GIT_SSH=/home/fold/.ssh/deploy-wrapper git pull origin #{ENV['BRANCH']} && sudo bundle --binstubs --without test && sudo chown -R fold ."
    ssh "cd /opt/prism; sudo cp conf/prism.conf /etc/init/prism.conf; sudo cp conf/prism_back.conf /etc/init/prism_back.conf; sudo cp conf/sweeper.conf /etc/init/sweeper.conf"
    ssh "sudo stop prism_back; sudo start prism_back; sudo stop sweeper; sudo start sweeper"
  end
  
  task :bounce do
    ssh "sudo restart prism_back; sudo restart sweeper"
  end
  
  task :restart_prism do
    raise "This is fucking dangerous!"
    ssh "sudo restart prism"
  end
  
  task :logs do
    FileUtils.mkdir_p 'tmp/logs'
    puts `scp -i #{ENV['EC2_SSH']} ubuntu@pluto.minefold.com:/var/log/syslog* tmp/logs`
  end
end

namespace :graphite do
  desc "Deploy the graphite dashboard.conf"
  task :dashboard do
    `scp -i .ssh/minefold.pem conf/graphite/dashboard.conf ubuntu@pluto.minefold.com:/opt/graphite/conf/dashboard.conf`
  end
end