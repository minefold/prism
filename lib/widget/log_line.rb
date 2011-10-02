class LogLine
  attr_reader :line, :timestamp, :level, :message, :user, :chat_message, :type

  def initialize line
    @line = line
    line =~ /(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})\s\[(\w+)\]\s(.*)/
    @timestamp = Time.parse $1 if $1
    @level = $2
    @message = $3
    
    if message =~ /^\<(\w+)\> (.*)/
      @type = :chat_message
      @user = $1
      @chat_message = $2
    elsif message =~ /^(\S*) .* logged in/
      @type = :player_connected
      @user = $1
      puts "#{@user} connected"
    elsif message =~ /^(\S*) lost connection/
      @type = :player_disconnected
      @user = $1
      puts "#{@user} disconnected"
    elsif message =~ /^Done/
      @type = :world_started
    end
  end
  
  def chat_user
    @user
  end
end