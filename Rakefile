$:.unshift File.join File.dirname(__FILE__), 'lib'
require 'rake/clean'

CLEAN.add 'tmp'
CLOBBER.add 'data'

task :default => :minecraft

task :minecraft => 'minecraft:start'
namespace :mc do
  CLEAN.add 'mc/*.txt', 'mc/server.log*'
  CLOBBER.add 'mc/world', 'mc/server.jar'

  desc 'Manually starts the MineCraft server'
  task :start do
    Dir.chdir('mc') do
      sh 'java -Xmx1024M -Xms512M -jar server.jar nogui'
    end
  end

  desc 'Downloads the latest version of the server from minecraft.net'
  task :pull do
    sh 'curl -L http://www.minecraft.net/download/minecraft_server.jar -o mc/server.jar'
  end
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  t.pattern = 'spec/**/*_spec.rb'
end