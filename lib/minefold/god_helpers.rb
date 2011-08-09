module GodHelpers
  
  def rvm?
    `rvm --version` rescue false
    $?.exitstatus == 0
  end
  
  def sudo_cmd
    rvm? ? 'rvmsudo' : 'sudo'
  end

  def sudo cmd
    full_cmd = "cd #{ROOT} && #{sudo_cmd} #{cmd}"
    result = `#{full_cmd}`
    p "#{full_cmd}:#{$?.exitstatus}\n#{result}"
  end

  def god cmd
    if File.exists? "#{ROOT}/bin/god"
      sudo "#{ROOT}/bin/god #{cmd}"
    else
      sudo "bundle exec god #{cmd}"
    end
  end

  def god_running?
    god "status"
    $?.exitstatus == 0
  end

  def god_start config_file, task
    if god_running?
      god "load #{config_file}"
    else   
      god "-c #{config_file}"
    end
    god "start #{task}"
  end
  
  def god_stop task_name
    god "stop #{task_name}"
  end
end