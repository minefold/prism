module Minefold
  module Redis
    def redis
      @redis ||= begin
        uri = URI.parse(ENV['REDIS_URL'] || 'redis://localhost:6379/')
        ::Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
      end
    end
  end
end