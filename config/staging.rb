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
MONGOHQ_URL="mongodb://heroku:5fb18d7c862247982989d24305e3725c@staff.mongohq.com:10022/app650848"
REDISTOGO_URL="redis://redistogo:a41865a64de42e31b2022186ad94bd38@angler.redistogo.com:9095/"
PUSHER_URL="http://d7a615c1e88b0696d3f1:665ba5c2f03785e75e84@api.pusherapp.com/apps/7184"

SSH_PRIVATE_KEY_PATH="#{ROOT}/.ssh/minefold.pem"

Fold.workers = :cloud
Fold.worker_tags = { :environment => :staging }
Fold.worker_git_branch = :dev
Fold.worker_user = 'ubuntu'

Storage.provider = Fog::Storage.new({
  :provider                 => :aws,
  :aws_secret_access_key    => EC2_SECRET_KEY,
  :aws_access_key_id        => EC2_ACCESS_KEY
})