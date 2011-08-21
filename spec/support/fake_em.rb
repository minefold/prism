module EM
  def self.defer operation, callback
    callback.call operation.call
  end
end