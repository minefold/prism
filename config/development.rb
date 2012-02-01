ROOT = File.expand_path "../..", __FILE__
BIN = "#{ROOT}/bin"
LIB = "#{ROOT}/lib"
WORLDS = "#{ROOT}/worlds"
LOG_PATH = "#{ROOT}/log"

JAR = "#{WORLDS}/server.jar"
PIDS = "#{ROOT}/tmp/pids"

EC2_SECRET_KEY="4VI8OqUBN6LSDP6cAWXUo0FM1L/uURRGIGyQCxvq"
EC2_ACCESS_KEY="AKIAJPN5IJVEBB2QE35A"
MONGOHQ_URL='mongodb://localhost/'
REDISTOGO_URL="redis://localhost:6379/"
PUSHER_URL="http://d6ddfd6bf3e166ae0ce6:aa7e63965d17d964678c@api.pusherapp.com/apps/7185"
MAPPER = "~/code/minefold/pigmap/pigmap"
MIXPANEL_TOKEN = nil
AIRBRAKE_TOKEN = nil
WORLDS_BUCKET = 'minefold.production.worlds'

Fold.workers = :local
Fold.worker_user = ENV['USER']

# Storage.provider = Fog::Storage.new({
#   :provider      => :local,
#   :local_root    => "#{ROOT}/tmp/local_storage"
# })
Storage.provider = Fog::Storage.new({
  :provider                 => :aws,
  :aws_secret_access_key    => EC2_SECRET_KEY,
  :aws_access_key_id        => EC2_ACCESS_KEY
})

StatsD.logger = Logger.new('/dev/null')
StatsD.mode = :development