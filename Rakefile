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
  uri = URI.parse(ENV['REDIS_URL'] || 'redis://localhost:6379/')
  Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

require 'resque'
require 'resque/tasks'

task "resque:setup" do
  require 'bundler/setup'
  Bundler.require :default, :chatty
  require 'minefold'

  if REDIS_URL
    Resque.redis = redis_connect
  end
end

namespace :jobs do
  task :world_started => "resque:setup" do
    Resque.push 'low', class: 'WorldStartedJob', args: [ENV['WORLD_ID'] || '4e7d843f9fe7af003e000001']
  end

  task :chat => "resque:setup" do
    Resque.push 'high', class: 'ProcessChatJob', args: [ (ENV['WORLD_ID'] || '4e7d843f9fe7af003e000001'), ENV['USER'] || 'whatupdave', ENV['MESSAGE'] || 'test message' ]
  end
end

def ssh cmd
  ssh_options={ 'BatchMode' => 'yes',
    'CheckHostIP' => 'no',
    'ForwardAgent' => 'yes',
    'StrictHostKeyChecking' => 'no',
    'UserKnownHostsFile' => '/dev/null' }.map{|k, v| "-o #{k}=#{v}"}.join(' ')

  ssh_cmd = %Q{ssh -i #{ENV['EC2_SSH']} #{ssh_options} ubuntu@#{ENV['HOST']} "#{cmd}"}
  puts `#{ssh_cmd}`
end

def ssh_connect
  system %Q{ssh -i #{ENV['EC2_SSH']} ubuntu@#{ENV['HOST']} "#{cmd}"}
end

def set_host
  ENV['HOST'] ||= `ec2-describe-instances --hide-tags --filter instance-id=#{ENV['INSTANCE_ID']} | grep #{ENV['INSTANCE_ID']} | cut -f4`.strip
end

namespace :prism do
  task :deploy do
    ssh "cd /opt/prism && sudo GIT_SSH=/home/fold/.ssh/deploy-wrapper git pull origin #{ENV['BRANCH']} && sudo bundle --binstubs --without test && sudo chown -R fold ."
  end

  task :bounce do
    ssh "sudo restart prism_back; sudo restart sweeper"
  end

  task :restart_prism do
    raise "This is fucking dangerous!"
    ssh "sudo stop prism; sudo start prism"
  end

  task :logs do
    FileUtils.mkdir_p 'tmp/logs'
    puts `scp -i #{ENV['EC2_SSH']} ubuntu@pluto.minefold.com:/var/log/syslog* tmp/logs`
  end
end
