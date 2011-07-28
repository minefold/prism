ROOT = File.expand_path "../..", __FILE__
BIN = "#{ROOT}/bin"
LIB = "#{ROOT}/lib"
WORLDS = "#{ROOT}/worlds"
LOG_PATH = "#{ROOT}/log"

JAR = "#{WORLDS}/server.jar"
PIDS = "#{ROOT}/tmp/pids"

# TODO: put these somewhere more secure
EC2_SECRET_KEY="4VI8OqUBN6LSDP6cAWXUo0FM1L/uURRGIGyQCxvq"
EC2_ACCESS_KEY="AKIAJPN5IJVEBB2QE35A"
MONGOHQ_URL="mongodb://heroku:15a8f355615361aeda458c6d887aada2@staff.mongohq.com:10023/app650862"
REDISTOGO_URL="redis://redistogo:0128df27dcecc0dac569b231d5bd7ccb@angler.redistogo.com:9097/"
PUSHER_URL="http://e7fc68c29773ff816794:8f58121bba8d8983f10b@api.pusherapp.com/apps/7187"

SSH_PRIVATE_KEY_PATH="#{ROOT}/.ssh/minefold.pem"

Fold.workers = :cloud
Fold.worker_tags = { :environment => :production }
Fold.worker_git_branch = :master

Storage.provider = Fog::Storage.new({
  :provider                 => :aws,
  :aws_secret_access_key    => EC2_SECRET_KEY,
  :aws_access_key_id        => EC2_ACCESS_KEY
})