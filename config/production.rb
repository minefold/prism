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
MONGOHQ_URL="mongodb://heroku:os304dfe5d3tbkn3r1ko8j@staff.mongohq.com:10002/app578527"
REDISTOGO_URL="redis://redistogo:9b5f916f86dd29f26ca4af54c3f8f768@catfish.redistogo.com:9527/"

SSH_PRIVATE_KEY_PATH="#{ROOT}/.ssh/minefold.pem"

Fold.workers = :cloud
Storage.provider = Fog::Storage.new({
  :provider                 => :aws,
  :aws_secret_access_key    => EC2_SECRET_KEY,
  :aws_access_key_id        => EC2_ACCESS_KEY
})