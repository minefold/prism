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

SSH_PRIVATE_KEY_PATH="#{ROOT}/.ssh/minefold.pem"