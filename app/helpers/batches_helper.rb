module BatchesHelper
    def batch_select_options
        Batch.statuses.keys
    end
end
