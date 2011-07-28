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
MONGOHQ_URL="mongodb://heroku:b40c32f8f5707512d7b68b80d35fd260@staff.mongohq.com:10023/app631445"
REDISTOGO_URL="redis://redistogo:95b8515d29d7bf5258606a0764215c3c@catfish.redistogo.com:9622/"

SSH_PRIVATE_KEY_PATH="#{ROOT}/.ssh/minefold.pem"

Fold.workers = :cloud
Fold.worker_tags = { :environment => :staging }
Storage.provider = Fog::Storage.new({
  :provider                 => :aws,
  :aws_secret_access_key    => EC2_SECRET_KEY,
  :aws_access_key_id        => EC2_ACCESS_KEY
})