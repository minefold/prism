module Prism
  class WorkerStopRequest < BusyOperationRequest
    process "workers:requests:stop", :instance_id

    def busy_hash
      ["workers:busy", instance_id, state:'stopping']
    end

    def perform_operation
      info "stopping box:#{instance_id}"

      df = EM::DefaultDeferrable.new

      Box.find instance_id do |box|
        if box
          op = box.stop
          op.callback { df.succeed box }
          op.errback  { df.fail }
        else
          error "failed to find box:#{instance_id}"
          df.fail
        end
      end

      df
    end

    def operation_succeeded box
      info "stopped box:#{instance_id}"
      redis.unstore_running_box instance_id, box.host
    end

    def operation_failed
      error "failed to stop box:#{instance_id}"
    end
  end
end