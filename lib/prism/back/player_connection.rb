module Prism
  module Back
    module PlayerConnection
      def reject_player username, reason, options = {}
        rejection = ({rejected: reason}).merge(options)
        mixpanel_track 'rejected', rejection
        redis.publish_json "players:connection_request:#{username}", rejection
      end
    end
  end
end