ROOT = File.expand_path "../..", __FILE__
BIN = "#{ROOT}/bin"
LIB = "#{ROOT}/lib"
WORLDS = "#{ROOT}/worlds"

JAR = "#{WORLDS}/server.jar"
PIDS = "#{ENV['HOME']}/.god/pids"

# TODO: put these somewhere more secure
EC2_SECRET_KEY="4VI8OqUBN6LSDP6cAWXUo0FM1L/uURRGIGyQCxvq"
EC2_ACCESS_KEY="AKIAJPN5IJVEBB2QE35A"

SSH_PRIVAYE_KEY_PATH="#{ROOT}/.ssh/minefold.pem"