set :application, "minefold"
set :repository,  "git@github.com:minefold/prism.git"

set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :user, 'ubuntu'
set :deploy_to, '/tmp/prism'

ssh_options[:forward_agent] = true
ssh_options[:keys] = ['.ec2/east/minefold2.pem']

role :prism_back, "pluto.minefold.com"
