ROOT = File.expand_path "../..", __FILE__
BIN = "#{ROOT}/bin"
LIB = "#{ROOT}/lib"
WORLDS = "#{ROOT}/worlds"
LOG_PATH = "#{ROOT}/log"

JAR = "#{WORLDS}/server.jar"
PIDS = "#{ROOT}/tmp/pids"

MONGOHQ_URL='mongodb://localhost'
REDISTOGO_URL="redis://localhost/"
PUSHER_URL="http://d6ddfd6bf3e166ae0ce6:aa7e63965d17d964678c@api.pusherapp.com/apps/7185"

Fold.workers = :local
Fold.worker_git_branch = :dev
Fold.worker_user = ENV['USER']

Storage.provider = Fog::Storage.new({
  :provider      => :local,
  :local_root    => "#{ROOT}/tmp/local_storage"
})
