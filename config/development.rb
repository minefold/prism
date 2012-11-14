ROOT = File.expand_path "../..", __FILE__

EC2_SECRET_KEY="4VI8OqUBN6LSDP6cAWXUo0FM1L/uURRGIGyQCxvq"
EC2_ACCESS_KEY="AKIAJPN5IJVEBB2QE35A"
MONGOHQ_URL='mongodb://localhost/'
REDISTOGO_URL="redis://localhost:6379/"
MAPPER = "~/code/minefold/pigmap/pigmap"
WORLDS_BUCKET = OLD_WORLDS_BUCKET = ENV['WORLDS_BUCKET'] || 'minefold-development-worlds'
INCREMENTAL_WORLDS_BUCKET = ENV['INCREMENTAL_WORLDS_BUCKET'] || 'minefold-development'

Fold.workers = :local
Fold.worker_user = ENV['USER']

StatsD.logger = Logger.new(STDOUT) #Logger.new('/dev/null')
StatsD.mode = :development

# ENV['RACK_ENV'] = 'production' # exceptional gem looks at this ENV
# Exceptional::Config.load("#{ROOT}/config/exceptional.yml")

TEST_PRISM="localhost"