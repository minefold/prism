class LogLine
  attr_reader :line, :timestamp, :level, :message, :chat_user, :chat_message

  def initialize line
    @line = line
    line =~ /(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})\s\[(\w+)\]\s(.*)/
    @timestamp = Time.parse $1
    @level = $2
    @message = $3
    
    message =~ /^\<(\w+)\> (.*)/
    @chat_user = $1
    @chat_message = $2
  end
  
  def world_started?
    message =~ /^Done/
  end
  
  def save_complete?
    message =~ /^CONSOLE: Save complete/i
  end
end