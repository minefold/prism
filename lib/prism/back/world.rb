class World
  extend Prism::Mongo

  def self.find id, *a, &b
    find_one({"_id" => BSON::ObjectId(id.to_s)}, *a, &b)
  end

  def self.find_one options, *a, &b
    cb = EM::Callback *a, &b
    EM.defer(proc {
      doc = collection.find_one options
      new doc if doc
    }, proc { |user|
      cb.call user
    })
    cb
  end

  def self.collection
    mongo_connect.collection('worlds')
  end

  def initialize doc
    @doc = doc
  end

  def id
    @doc['_id']
  end

  def slug
    @doc['slug']
  end

  def data_file
    # TODO: remove this later due to world_id in file bug
    File.split(@doc['world_data_file']).last if @doc['world_data_file']
  end

  def has_data_file?
    return true if data_file.nil?

    Storage.worlds.exists?("#{id}/#{data_file}") || Storage.old_worlds.exists?(data_file)
  end
end