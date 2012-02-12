class User
  extend Prism::Mongo
  
  def self.find id, *a, &b
    find_one({"_id" => BSON::ObjectId(id.to_s)}, *a, &b)
  end
  
  def self.find_by_username username, *a, &b
    find_one({:safe_username => username.downcase.strip}, *a, &b)
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
    mongo_connect.collection('users')
  end
  
  def initialize doc
    @doc = doc
  end
  
  def update options
    EM.defer do
      self.class.collection.update({'_id' => id}, options)
    end
  end
  
  def id
    @doc['_id']
  end
  
  def has_credit?
    unlimited? || credits > 0
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