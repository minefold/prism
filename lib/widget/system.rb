class System
  def self.memory_usage
    `which free`
    if $?.exitstatus == 0
      parts = `free -m`.split
      { total:parts[7].to_i, used:parts[8].to_i }
    else
      { total:4096, used:1024 }
    end
  end
end