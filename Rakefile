require 'rake/clean'
CLEAN.add 'mc/*.txt', 'mc/server.log*'
CLOBBER.add 'mc/world'

desc "Start mc server"
task :minecraft do
  Dir.chdir('mc') { exec 'java -Xmx1024M -Xms512M -jar server.jar nogui'}
end

desc "Start redis"
task :redis do
  sh "redis-server conf/redis.conf"
end

namespace :foreman do
  desc "Destroys all world files"
  task :nuke do
    sh "rm -rf foreman/servers"
    sh "rm -rf worlds"
  end
  
  desc "Kills all running servers"
  task :kill do
    sh "ps | grep 'java' | awk '{print $1}' | xargs kill -9"
  end
end