require 'prism/prism_redis'
require 'prism/back/queue_processor'
require 'prism/back/request'

Dir[File.expand_path('../back/requests/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../back/events/*.rb', __FILE__)].each { |f| require f }
