module Prism
  module Mongo
    extend Debugger

    def mongo_connect
      @connection ||= begin
        mongo = ::Mongo::Connection.from_uri(ENV['MONGOHQ_URL'] || MONGOHQ_URL)
        db_name = mongo.auths.any? ? mongo.auths.first['db_name'] : 'minefold'
        mongo[db_name]
      end
    end
  end
end

