class User < Model
  extend Prism::Mongo

  collection :users

  def self.find_by_slug slug, *a, &b
    find_one({deleted_at: nil, slug: slug}, *a, &b)
  end

  def self.find_by_username username, *a, &b
    find_one({deleted_at: nil, safe_username: username.downcase.strip}, *a, &b)
  end

  def self.find_by_verification_code(code, *a, &b)
    find_one({deleted_at: nil, verification_code: code}, *a, &b)
  end

  def email
    @doc['email']
  end

  def username
    @doc['username']
  end

  def slug
    username.downcase
  end

  def mpid
    @doc['mpid'] || id
  end

  def has_credit?
    plan_or_unlimited? || credits > 0
  end

  def limited_time?
    (not valid_plan?) and (not unlimited?)
  end

  def plan_or_unlimited?
    valid_plan? or unlimited?
  end

  def unlimited?
    @doc['unlimited'] or @doc['beta']
  end

  def valid_plan?
    @doc['plan_expires_at'] and (@doc['plan_expires_at'] > Time.now)
  end

  def current_world_id
    @doc['current_world_id']
  end

  def credits
    @doc['credits']
  end

  def minutes_played
    @doc['minutes_played']
  end

  def plan_status
    case
    when unlimited?
      "UNLIMITED"
    when valid_plan?
      "Plan expires: #{@doc['plan_expires_at'].strftime('%d %b %Y')}"
    else
      "#{credits} credits remaining"
    end
  end
end