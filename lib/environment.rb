ROOT = File.expand_path "../..", __FILE__
BIN = "#{ROOT}/bin"
LIB = "#{ROOT}/lib"
WORLDS = "#{ROOT}/worlds"
LOG_PATH = "#{ROOT}/log"

JAR = "#{WORLDS}/server.jar"
PIDS = "#{ENV['HOME']}/.god/pids"

# TODO: put these somewhere more secure
EC2_SECRET_KEY="4VI8OqUBN6LSDP6cAWXUo0FM1L/uURRGIGyQCxvq"
EC2_ACCESS_KEY="AKIAJPN5IJVEBB2QE35A"
MONGOHQ_URL="mongodb://heroku:os304dfe5d3tbkn3r1ko8j@staff.mongohq.com:10002/app578527"

SSH_PRIVATE_KEY_PATH="#{ROOT}/.ssh/minefold.pem"