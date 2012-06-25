ROOT = File.expand_path "../..", __FILE__

# TODO: put these somewhere more secure
EC2_SECRET_KEY="4VI8OqUBN6LSDP6cAWXUo0FM1L/uURRGIGyQCxvq"
EC2_ACCESS_KEY="AKIAJPN5IJVEBB2QE35A"
# MONGOHQ_URL="mongodb://minefold:Aru06kAy8xE2@sun.member0.mongohq.com:10018/production,minefold:Aru06kAy8xE2@sun.member1.mongohq.com:10018/production"
MONGOHQ_URL="mongodb://minefold:Aru06kAy8xE2@sun.member0.mongohq.com:10018/production"
REDISTOGO_URL="redis://redistogo:0128df27dcecc0dac569b231d5bd7ccb@angler.redistogo.com:9097/"
MIXPANEL_TOKEN = '34356c196fac389dff577bf3e1a2164a'
WORLDS_BUCKET = 'minefold-production-worlds'
OLD_WORLDS_BUCKET = 'minefold.production.worlds'
INCREMENTAL_WORLDS_BUCKET = ENV['INCREMENTAL_WORLDS_BUCKET'] || 'minefold-production'

uri = URI.parse(REDISTOGO_URL)
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

SSH_PRIVATE_KEY_PATH=ENV['EC2_SSH'] || "#{ROOT}/.ec2/east/minefold2.pem"

Fold.workers = :cloud
Fold.worker_tags = { :environment => :production }
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
