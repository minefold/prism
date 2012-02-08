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
  
  task :map_all_worlds => "resque:setup" do 
    require 'jobs'
    require 'prism/back'
    include Prism::Mongo
    def mongo
      @mongo ||= mongo_connect
    end
    
    mongo['worlds'].find.map {|w| w['_id'].to_s }.each do |world_id|
      Resque.enqueue(Job::MapWorld, world_id)
    end
  end
  
  task :world_started => "resque:setup" do
    Resque.push 'low', class: 'WorldStartedJob', args: [ENV['WORLD_ID'] || '4e7d843f9fe7af003e000001']
  end
  
  task :chat => "resque:setup" do
    Resque.push 'high', class: 'ProcessChatJob', args: [ (ENV['WORLD_ID'] || '4e7d843f9fe7af003e000001'), ENV['USER'] || 'whatupdave', ENV['MESSAGE'] || 'test message' ]
  end
end

def ssh cmd
  ssh_cmd = %Q{ssh -i #{ENV['EC2_SSH']} ubuntu@#{ENV['HOST']} "#{cmd}"}
  puts `#{ssh_cmd}`
end

def ssh_connect
  system %Q{ssh -i #{ENV['EC2_SSH']} ubuntu@#{ENV['HOST']} "#{cmd}"}
end

def set_host
  ENV['HOST'] ||= `ec2-describe-instances --hide-tags --filter instance-id=#{ENV['INSTANCE_ID']} | grep #{ENV['INSTANCE_ID']} | cut -f4`.strip
end

namespace :widget do
  task :ssh do
    set_host
    ssh
  end
  
  task :deploy do
    set_host
    ENV['BRANCH'] ||= 'master'
    ssh "cd /opt/widget && sudo GIT_SSH=/home/fold/.ssh/deploy-wrapper git pull origin #{ENV['BRANCH']} && bin/restart-widget"
  end
end

namespace :prism do
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

namespace :atlas do
  task :deploy do
    ENV['HOST'] ||= 'mapper.minefold.com'
    ssh "cd atlas && git pull origin master && sudo stop atlas && rm -rf tmp && sudo start atlas"
  end
end

namespace :graphite do
  desc "Deploy the graphite dashboard.conf"
  task :dashboard do
    `scp -i .ssh/minefold.pem conf/graphite/dashboard.conf ubuntu@pluto.minefold.com:/opt/graphite/conf/dashboard.conf`
  end
end

namespace :servers do
  
  require 'prism/back'
  include Prism::Mongo
  def mongo
    @mongo ||= mongo_connect
  end
  
  namespace :bukkit do
    desc "update bukkit server"
    task :update do
      server_url = 'http://repo.bukkit.org/service/local/artifact/maven/redirect?g=org.bukkit&a=craftbukkit&v=RELEASE&r=releases'
      jar_info = `curl -IL --silent --show-error '#{server_url}'`.strip.split("\n").each_with_object({}) do |line, h| 
        if line.include? ':'
          key, value = line.split(':', 2)
          h[key] = value.strip.gsub('"', '')
        end
      end
      
      # p jar_info

      current_etag = jar_info['ETag']

      minecraft_servers = mongo['game_servers'].find_one({:name => 'minecraft'})
      unless minecraft_servers and minecraft_servers['versions'].any?{|v| v['etag'] == current_etag }
        # download server
        puts "downloading new bukkit server #{jar_info['Last-Modified']}"
        local_file = "tmp/bukkit/#{current_etag}/server.jar"
        FileUtils.mkdir_p File.dirname(local_file)
        
        puts `curl --silent --show-error -L '#{server_url}' -o #{local_file}`

        # determine server version
        version = ENV['VERSION']
        version = "bukkit-#{version}" unless version.include? 'bukkit'
        raise 'Need VERSION' unless version

        # upload server
        remote_file = "minecraft/#{version}/server.jar"
        puts "uploading #{remote_file}"
        bucket = Storage.new.game_servers

        bucket.files.create(
          key: remote_file,
          body: File.read(local_file),
          public: false
        )

        version_info = { 
          'name' => version,
          'etag' => current_etag,
          'created_at' => Time.parse(jar_info['Last-Modified'])
        }

        # record server in database
        mongo['game_servers'].update({
          name: 'minecraft'
        }, {
          '$push' => { 'versions' => version_info }
        }, upsert: true)
        puts "saved #{version_info.inspect}"
      end
    end
  end
  
  desc "store latest server"
  task :update do
    server_url = 'https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft_server.jar'
    jar_info = `curl -I --silent --show-error #{server_url}`.strip.split("\n").each_with_object({}) do |line, h| 
      if line.include? ':'
        key, value = line.split(':', 2)
        h[key] = value.strip.gsub('"', '')
      end
    end
  
    current_etag = jar_info['ETag']
    
    minecraft_servers = mongo['game_servers'].find_one({:name => 'minecraft'})
    unless minecraft_servers and minecraft_servers['versions'].any?{|v| v['etag'] == current_etag }
      local_file = "tmp/#{current_etag}/server.jar"
      FileUtils.mkdir_p File.dirname(local_file)
      
      # download server
      puts "downloading new minecraft server #{jar_info['Last-Modified']} #{local_file}"
      `curl --silent --show-error -L #{server_url} -o #{local_file}`
      
      # determine server version
      version = ENV['VERSION']
      raise 'Need VERSION' unless version
      
      # upload server
      remote_file = "minecraft/#{version}/bukkit.jar"
      puts "uploading #{remote_file}"
      bucket = Storage.new.game_servers
      
      bucket.files.create(
        key: remote_file,
        body: File.read(local_file),
        public: false
      )
      
      version_info = { 
        'name' => version,
        'etag' => current_etag,
        'created_at' => Time.parse(jar_info['Last-Modified'])
      }
      
      # record server in database
      mongo['game_servers'].update({
        name: 'minecraft'
      }, {
        '$push' => { 'versions' => version_info }
      }, upsert: true)
      puts "saved #{version_info.inspect}"
    end
  end
end