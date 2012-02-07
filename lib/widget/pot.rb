module Widget
  class Pot
    def self.spawn_pot_process path, pid_file, cmd, stdin_file, stdout_file, stderr_file, *a, &b
      cb = EM::Callback *a, &b
      FileUtils.mkdir_p PID_PATH
      pot_cmd = "#{BIN}/pot #{stdin_file} #{stdout_file} #{stderr_file} #{pid_file} #{cmd}"
      puts pot_cmd
      Process.spawn_detached path, pot_cmd

      file_wait_timer = EM.add_periodic_timer(1) do
        if File.exist?(pid_file) && File.exist?("#{path}/#{stdout_file}")
          file_wait_timer.cancel
          puts "pot started:#{pid_file}"

          cb.call
        end
      end
      cb
    end
  end
end