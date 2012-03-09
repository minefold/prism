class World
  extend Prism::Mongo

  def self.find id, *a, &b
    find_one({"_id" => BSON::ObjectId(id.to_s)}, *a, &b)
  end

  def self.find_by_slug creator_slug, world_slug, *a, &b
    cb = EM::Callback *a, &b
    User.find_by_slug(creator_slug) do |user|
      if user
        find_one({
          creator_id: user.id,
          slug: world_slug
        }) do |world|
          cb.call world
        end
      else
        cb.call nil
      end
    end
    cb
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
  
  def name
    @doc['name']
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