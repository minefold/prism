class Player < Model
  FREE_MINUTES = 600
  
  collection :players

  def self.find_by_username username, *a, &b
    find_one({slug: sanitize(username)}, *a, &b)
  end

  def self.upsert_by_username username, *a, &b
    slug = sanitize(username)
    opts = {
      query: {
        slug: slug
      }, update: {
        slug: slug,
        username: username,
        distinct_id: `uuidgen`.strip,
        created_at: Time.now,
        updated_at: Time.now,
        last_connected_at: Time.now,
        unlock_code: rand(36 ** 4).to_s(36)
      },
      new: true,
      upsert: true
    }
    
    find_and_modify(opts, *a, &b)
  end

  def self.sanitize username
    username.downcase.strip
  end
  
  def user_id
    @doc['user_id']
  end

  def slug
    @doc['slug']
  end

  def username
    @doc['username']
  end

  def distinct_id
    @doc['distinct_id']
  end

  def last_connected_at
    @doc['last_connected_at']
  end

  def minutes_played
    @doc['minutes_played'] || 0
  end
  
  def has_credit?
    minutes_played < FREE_MINUTES
  end
end