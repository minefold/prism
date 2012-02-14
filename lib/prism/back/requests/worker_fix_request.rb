module Prism
  class WorkerFixRequest < BusyOperationRequest
    process "workers:requests:fix", :instance_id

    def busy_hash
      ["workers:busy", instance_id, state:'fixing']
    end

    def perform_operation
      info "repairing worker:#{instance_id}"
      # worker = Worker.find instance_id
      #
      # worker.prepare_for_minefold
      df = EM::DefaultDeferrable.new
      df.fail
      df
    end

    def operation_succeeded worker
      info "fixed worker:#{instance_id}"

      redis.publish "workers:requests:fix:#{instance_id}", instance_id
    end

    def operation_failed
      error "failed to fix worker:#{instance_id}"
    end
  end
end