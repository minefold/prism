$:.unshift File.join File.dirname(__FILE__), 'lib'

require 'rake/clean'
require 'resque/tasks'

CLEAN.add 'mc/*.txt', 'mc/server.log*'
CLOBBER.add 'mc/world'

desc "Start mc server"
task :minecraft do
  Dir.chdir('mc') { exec 'java -Xmx1024M -Xms512M -jar server.jar nogui'}
end

CLEAN.add 'tmp'
CLOBBER.add 'data'

desc "Get latest mc server"
task :get_latest_server do
  exec 'curl -L http://www.minecraft.net/download/minecraft_server.jar -o mc/server.jar'
end

task "resque:setup" do
  require 'bundler/setup'
  Bundler.require :default, :backup
  
  require 'jobs'
end

# namespace :foreman do
#   desc "Destroys all world files"
#   task :nuke do
#     sh "rm -rf foreman/servers"
#     sh "rm -rf worlds"
#   end
#
#   desc "Kills all running servers"
#   task :kill do
#     sh "ps | grep 'java' | awk '{print $1}' | xargs kill -9"
#   end
# end