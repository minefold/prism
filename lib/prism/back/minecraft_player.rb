class MinecraftPlayer < Model
  FREE_MINUTES = 600

  collection :minecraft_players

  attr_accessor :user

  def self.upsert_by_username username, *a, &b
    cb = EM::Callback(*a, &b)

    slug = sanitize(username)

    # for new documents
    default_properties = {
      slug: slug,
      username: username,
      distinct_id: `uuidgen`.strip,
      created_at: Time.now,
      updated_at: Time.now,
      unlock_code: rand(36 ** 4).to_s(36)
    }

    # for existing documents
    update_properties = {
      '$set' => {
        username: username,
        updated_at: Time.now
      }
    }

    find_one(deleted_at: nil, slug: slug) do |player|
      properties = player.nil? ? default_properties : update_properties
      opts = { query: { deleted_at: nil, slug: slug }, update: properties, upsert: true, new: true }
      find_and_modify(opts) do |player|
        cb.call player
      end
    end

    cb
  end

  def self.find_with_user id, *a, &b
    cb = EM::Callback(*a, &b)
    find(id) do |player|
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

  def self.find_by_username_with_user username, *a, &b
    cb = EM::Callback(*a, &b)
    find_one(deleted_at: nil, slug: sanitize(username)) do |player|
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
  
  %w(user_id
     slug
     username
     distinct_id
     last_connected_at
     minutes_played
  ).each do |field|
    define_method(:"#{field}") do
      @doc[field]
    end
  end
  
  def verified?
    not user.nil?
  end

  def has_credit?
    if user
      user.has_credit?
    else
      minutes_played < FREE_MINUTES
    end
  end

  def credits
    if user
      user.credits
    else
      FREE_MINUTES - minutes_played
    end
  end

  def limited_time?
    user.nil? or (user.limited_time?)
  end

  def plan_status
    if user
      user.plan_status
    else
      "#{FREE_MINUTES - minutes_played} remaining"
    end
  end
end