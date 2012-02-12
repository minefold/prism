class UserMailer
  @queue = :mailer

  def self.send_reminder user_id
    Resque.enqueue self, "reminder", user_id
  end
end

