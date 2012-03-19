module Prism
  class WorldMoveRequest < Request
    include Messaging
    include ChatMessaging

    process "worlds:move_request", :world_id, :slots

    # this is the process
    # 1. message gamers that the world is about to die
    # 2. restart world
    # 3. email players?

    def run
      info "moving world:#{world_id} to slots:#{slots}"

      redis.hget_json 'worlds:running', world_id do |world|
        @instance_id = world['instance_id']

        message_gamers do
          restart_world do
            info "completed move world:#{world_id} slots:#{slots}"
          end
        end
      end
    end

    def message_gamers *a, &b
      cb = EM::Callback *a, &b
      send_world_message @instance_id, world_id, "SORRY! This server needs to be restarted!"
      EM.add_timer(2) do
        send_world_message @instance_id, world_id, "Please reconnect in 30 seconds!"
        EM.add_timer(8) do
          op = redis.hgetall "players:playing"
          op.callback do |players|
            users = players.select{|username, player_world_id| player_world_id == world_id }.keys
            users.each do |username|
              redis.publish "players:disconnect:#{username}", "Please reconnect in 30 seconds!"
            end
            cb.call
          end
        end
      end
      cb
    end

    def restart_world *a, &b
      cb = EM::Callback *a, &b

      redis.lpush "workers:#{@instance_id}:worlds:requests:stop", world_id
      EM.add_timer(0.5) do
        redis.lpush_hash "worlds:start_request", world_id: world_id, slots: slots

        listen_once "worlds:start_request:#{world_id}" do
          cb.call
        end
      end

      cb
    end
  end
end