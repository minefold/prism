class World < Model
  extend Prism::Mongo

  collection :worlds

  DEFAULT_OPS = %W(chrislloyd whatupdave)

  def self.find_by_name creator_username, world_name, *a, &b
    cb = EM::Callback *a, &b
    MinecraftPlayer.find_by_username_with_user(creator_username) do |player|
      if player.user
        opts = {
          deleted_at: nil,
          creator_id: player.user_id,
          name: /#{world_name}/i
        }
        find_one(opts) do |world|
          cb.call world
        end
      else
        cb.call nil
      end
    end
    cb
  end

  %w(name
     slug
     world_data_file
     parent_id
     opped_player_ids
     whitelisted_player_ids
     banned_player_ids
     runpack
     allocation_slots
  ).each do |field|
    define_method(:"#{field}") do
      @doc[field]
    end
  end

  def op? player
    return true if DEFAULT_OPS.include? player.username

    (opped_player_ids || []).include? player.id
  end

  def whitelisted? player
    (whitelisted_player_ids || []).include? player.id
  end

  def banned? player
    (banned_player_ids || []).include? player.id
  end

  def has_data_file? *a, &b
    cb = EM::Callback *a, &b
    if data_file.nil?
      cb.call true
    else
      # TODO: world data_file's should include the full path world_id/world_id.tar.gz
      EM.defer do
        cb.call Storage.worlds.exists?("#{data_file}") ||
          Storage.worlds.exists?("#{id}/#{data_file}") ||
          Storage.worlds.exists?("#{parent_id}/#{data_file}") ||
          Storage.old_worlds.exists?(data_file)
      end
    end
    cb
  end
end