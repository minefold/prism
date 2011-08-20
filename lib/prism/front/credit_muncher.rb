module Prism
  module CreditMuncher
    def deduct_minutes amount
      return unless @client_connected

      EM.defer do
        user = DB['users'].find_and_modify({ 
                      query: {"_id"  => @user_objectid},
                      update:{"$inc" => {"credits" => -amount, "minutes_played" => amount }}
                    })
        credits = user['credits'] - amount
        info "deducting 1 credit. #{credits} remaining. Played:#{user['minutes_played']} minutes"

        EM.next_tick { minutes_updated credits }

        if credits <= 0
          EM.next_tick do
            info "disconnecting. 0 minutes remaining"
            close_connection
          end
        end
      end
    end
  end
end