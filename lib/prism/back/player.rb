class Player < Model
  FREE_MINUTES = 600
  
  collection :players
  attr_accessor :user

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
  
  def self.find_with_user id, *a, &b
    cb = EM::Callback(*a, &b)
    find_one({"_id" => BSON::ObjectId(id.to_s)}) do |player|
      if player.user_id
        User.find(player.user_id) do |u| 
          player.user = u
          cb.call player
        end
      else
        cb.call player
      end
    end
  end
  
  def self.upsert_by_username_with_user username, *a, &b
    cb = EM::Callback(*a, &b)
    upsert_by_username(username) do |player|
      if player.user_id
        User.find(player.user_id) do |u| 
          player.user = u
          cb.call player
        end
      else
        cb.call player
      end
    end
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
    if user
      user.has_credit?
    else
      minutes_played < FREE_MINUTES
    end
  end
  
  # should we deduct credits from associated user?
  def limited_time?
    user && (not user.plan_or_unlimited?)
  end
  
  def plan_status
    if user
      user.plan_status
    else
      "#{FREE_MINUTES - minutes_played} remaining"
    end
  end
end