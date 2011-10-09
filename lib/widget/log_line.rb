class LogLine
  attr_reader :line, :timestamp, :level, :message, :user, :chat_message, :type, :log_entry, :players

  def initialize line
    @line = line
    line =~ /(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})\s\[(\w+)\]\s(.*)/
    @timestamp = Time.parse $1 if $1
    @level = $2
    @message = $3
    
    @log_entry = message || line
    
    if message =~ /^\<(\w+)\> (.*)/
      @type = :chat_message
      @user = $1
      @chat_message = $2
      @log_entry = "[#{user}] #{chat_message}"
    elsif message =~ /Connected players: (.*)$/i
      @type = :connected_players
      @players = $1.strip.split(', ')
    elsif message =~ /^(\S*) .* logged in/
      @type = :player_connected
      @user = $1
      @log_entry = "[#{user}] connected"
    elsif message =~ /^(\S*) lost connection/
      @type = :player_disconnected
      @user = $1
      @log_entry = "[#{user}] disconnected"
    elsif message =~ /^Done/
      @type = :world_started
      @log_entry = "world started"
    elsif message =~ /failed to bind to port/i
      @type = :port_taken
      @log_entry = "failed to bind port"
    end
  end
  
  def chat_user
    @user
  end
end