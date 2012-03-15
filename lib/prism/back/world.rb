class World < Model
  extend Prism::Mongo

  collection :worlds

  DEFAULT_OPS = %W(chrislloyd whatupdave)

  def self.find_by_name creator_username, world_name, *a, &b
    cb = EM::Callback *a, &b
    MinecraftPlayer.find_by_username_with_user(creator_username) do |player|
      if player.user
        opts = {
          creator_id: player.user_id,
          name: /#{world_name}/i
        }
        p opts
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
  ).each do |field|
    define_method(:"#{field}") do
      @doc[field]
    end
  end

  def op? player
    return true if DEFAULT_OPS.include? player.username

    (op_ids || []).include? player.id
  end

  def whitelisted? player
    (whitelisted_player_ids || []).include? player.id
  end

  def banned? player
    (banned_player_ids || []).include? player.id
  end

  def has_data_file?
    return true if world_data_file.nil?

    # TODO: world data_file's should include the full path world_id/world_id.tar.gz
    Storage.worlds.exists?("#{world_data_file}") ||
      Storage.worlds.exists?("#{id}/#{world_data_file}") ||
      Storage.worlds.exists?("#{parent_id}/#{world_data_file}") ||
      Storage.old_worlds.exists?(world_data_file)
  end
end