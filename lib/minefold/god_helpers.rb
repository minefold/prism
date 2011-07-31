module GodHelpers
  def sudo_cmd
    ENV['rvm_version'] ? 'rvmsudo' : 'sudo'
  end

  def sudo cmd
    `#{sudo_cmd} #{cmd}`
  end

  def god cmd
    if File.exists? "bin/god"
      sudo "bin/god" 
    else
      sudo "bundle exec god #{cmd}"
    end
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
  
  def god_stop task_name
    god "stop #{task_name}"
  end
end