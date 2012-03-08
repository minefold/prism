ROOT = File.expand_path "../..", __FILE__
BIN = "#{ROOT}/bin"
LIB = "#{ROOT}/lib"
WORLDS = File.expand_path("~/tmp/worlds")
LOG_PATH = "#{ROOT}/log"

JAR = "#{WORLDS}/server.jar"
PIDS = "#{ROOT}/tmp/pids"

# TODO: put these somewhere more secure
WORKER_GIT_REPO="git@github.com:minefold/widget.git"
EC2_SECRET_KEY="4VI8OqUBN6LSDP6cAWXUo0FM1L/uURRGIGyQCxvq"
EC2_ACCESS_KEY="AKIAJPN5IJVEBB2QE35A"
MONGOHQ_URL="mongodb://minefold:Aru06kAy8xE2@sun.member0.mongohq.com:10018/production"
REDISTOGO_URL="redis://redistogo:0128df27dcecc0dac569b231d5bd7ccb@angler.redistogo.com:9097/"
MIXPANEL_TOKEN = '34356c196fac389dff577bf3e1a2164a'
AIRBRAKE_TOKEN = '2a986c2b8d31075b30f812baeabb97f7'
WORLDS_BUCKET = 'minefold.production.worlds'

uri = URI.parse(REDISTOGO_URL)
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

SSH_PRIVATE_KEY_PATH=ENV['EC2_SSH'] || "#{ROOT}/.ec2/east/minefold2.pem"

Fold.workers = :cloud
Fold.worker_tags = { :environment => :production, :git_branch => :master }
Fold.worker_user = 'ubuntu'

Storage.provider = Fog::Storage.new({
  :provider                 => :aws,
  :aws_secret_access_key    => EC2_SECRET_KEY,
  :aws_access_key_id        => EC2_ACCESS_KEY
})

StatsD.server = 'stats.minefold.com:8125'
StatsD.mode = :production

ENV['RACK_ENV'] = 'production' # exceptional gem looks at this ENV
Exceptional::Config.load("#{ROOT}/config/exceptional.yml")
