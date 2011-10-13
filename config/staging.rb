ROOT = File.expand_path "../..", __FILE__
BIN = "#{ROOT}/bin"
LIB = "#{ROOT}/lib"
WORLDS = File.expand_path("~/tmp/worlds")
LOG_PATH = "#{ROOT}/log"

JAR = "#{WORLDS}/server.jar"
PIDS = "#{ROOT}/tmp/pids"

# TODO: put these somewhere more secure
WORKER_GIT_REPO="git@github.com:minefold/prism.git"
EC2_SECRET_KEY="4VI8OqUBN6LSDP6cAWXUo0FM1L/uURRGIGyQCxvq"
EC2_ACCESS_KEY="AKIAJPN5IJVEBB2QE35A"
MONGOHQ_URL="mongodb://heroku_app650862:96gg63iarmqm0tuq46knv4a8mb@dbh18.mongolab.com:27187/heroku_app650862"
REDISTOGO_URL="redis://redistogo:a41865a64de42e31b2022186ad94bd38@angler.redistogo.com:9095/"
# REDISTOGO_URL="redis://redistogo:0128df27dcecc0dac569b231d5bd7ccb@angler.redistogo.com:9097/"
PUSHER_URL="http://d7a615c1e88b0696d3f1:665ba5c2f03785e75e84@api.pusherapp.com/apps/7184"
MAPPER = "~/pigmap/pigmap"

uri = URI.parse(REDISTOGO_URL)
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

SSH_PRIVATE_KEY_PATH=ENV['EC2_SSH'] || "#{ROOT}/.ec2/east/minefold2.pem"

Fold.workers = :cloud
Fold.worker_tags = { :environment => :staging, :git_branch => :dev }
Fold.worker_user = 'ubuntu'

Storage.provider = Fog::Storage.new({
  :provider                 => :aws,
  :aws_secret_access_key    => EC2_SECRET_KEY,
  :aws_access_key_id        => EC2_ACCESS_KEY
})

StatsD.logger = Logger.new(STDOUT)
StatsD.mode = :staging