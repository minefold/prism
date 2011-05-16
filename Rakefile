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