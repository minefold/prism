module GodHelpers
  def sudo_cmd
    ENV['rvm_version'] ? 'rvmsudo' : 'sudo'
  end

  def sudo cmd
    `#{sudo_cmd} #{cmd}`
  end

  def god cmd
    sudo "bundle exec god #{cmd}"
  end

  def god_running?
    god "status"
    $?.exitstatus == 0
  end

  def god_start config_file, world_id
    if god_running?
      god "load #{config_file}"
      god "start #{world_id}"
    else   
      god "-c #{config_file}"
    end
  end
end