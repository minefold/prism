require 'base64'

module Mixpanel
  module EventTracker
    
    IGNORE_USERS = %w(system-check)
    
    def mixpanel
      Mixpanel::Tracker.new MIXPANEL_TOKEN, remote_ip
    end
    
    def mixpanel_track event, properties = {}
      mp_name = @mp_name ? @mp_name.downcase.strip : nil
      unless IGNORE_USERS.include? mp_name
        properties = { distinct_id: @mp_id.to_s, mp_name_tag: mp_name }.merge(properties)
        mixpanel.track event, properties.delete_if {|k,v| v.nil?}
      end
    end
  end
  
  class Tracker
    attr_reader :token, :ip
    
    def initialize token, ip
      @token, @ip = token, ip
    end
    
    def track event, properties = {}
      params = all_properties event, properties
      if token
        http = EventMachine::HttpRequest.new('http://api.mixpanel.com/track/').post body: { data: encoded_data(params) }
        http.errback { puts 'Mixpanel is down!' }
      else
        puts "mixpanel track:#{event} #{params.to_json}"
      end
    end

    def default_properties
      {
           ip: ip,
         time: Time.now.to_i,
        token: token
      }
    end
    
    def all_properties event, properties
      {
             event: event, 
        properties: default_properties.merge(properties)
      }
    end
    
    def encoded_data hash
      base64(JSON.generate(hash))
    end
    
    def base64 string
      Base64.encode64(string).gsub(/\n/, '')
    end
    
  end
  
end