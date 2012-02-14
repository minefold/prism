
class ProxyCommand
  def show
  end

  def tail_log
    exec %Q{ssh -i #{ROOT}/.ssh/minefold.pem ubuntu@pluto.minefold.com "tail -f ~/minefold/log/proxy.log"}
  end
end

