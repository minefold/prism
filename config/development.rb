ROOT = File.expand_path "../..", __FILE__

EC2_SECRET_KEY="4VI8OqUBN6LSDP6cAWXUo0FM1L/uURRGIGyQCxvq"
EC2_ACCESS_KEY="AKIAJPN5IJVEBB2QE35A"
MONGOHQ_URL='mongodb://localhost/'
REDISTOGO_URL="redis://localhost:6379/"
MAPPER = "~/code/minefold/pigmap/pigmap"
MIXPANEL_TOKEN = nil
WORLDS_BUCKET = OLD_WORLDS_BUCKET = ENV['WORLDS_BUCKET'] || 'minefold-development-worlds'

Fold.workers = :local
Fold.worker_user = ENV['USER']

# Storage.provider = Fog::Storage.new({
#   :provider      => :local,
#   :local_root    => "#{ROOT}/tmp/s3"
# })
Storage.provider = Fog::Storage.new({
  :provider                 => :aws,
  :aws_secret_access_key    => EC2_SECRET_KEY,
  :aws_access_key_id        => EC2_ACCESS_KEY
})

StatsD.logger = Logger.new('/dev/null')
StatsD.mode = :development

# ENV['RACK_ENV'] = 'production' # exceptional gem looks at this ENV
# Exceptional::Config.load("#{ROOT}/config/exceptional.yml")