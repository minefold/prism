class CreditMailer
  @queue = :mailer
  
  def self.send_low_credit user_id
    Resque.enqueue self, "low_credit", user_id
  end
end

