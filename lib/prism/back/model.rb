class Model
  extend Prism::Mongo

  attr_reader :doc

  def self.collection collection
    @collection = collection.to_s
  end

  def self.mongo_collection
    mongo_connect.collection(@collection)
  end

  def self.find_one options, *a, &b
    cb = EM::Callback *a, &b
    EM.defer(proc {
      doc = mongo_collection.find_one options
      new doc if doc
    }, proc { |user|
      cb.call user
    })
    cb
  end

  def self.find_all options, *a, &b
    cb = EM::Callback *a, &b
    EM.defer(proc {
      docs = mongo_collection.find options
      docs.map{|d| new d }
    }, proc { |user|
      cb.call user
    })
    cb
  end

  def self.find_and_modify options, *a, &b
    cb = EM::Callback *a, &b
    EM.defer(proc {
      doc = mongo_collection.find_and_modify options
      new doc if doc
    }, proc { |user|
      cb.call user
    })
    cb
  end

  def self.find id, *a, &b
    find_one({"_id" => BSON::ObjectId(id.to_s)}, *a, &b)
  end

  def initialize doc
    @doc = doc
  end

  def collection
    self.class.mongo_collection
  end

  def update options
    collection.update({'_id' => id}, options)
  end

  def id
    @doc['_id']
  end
end