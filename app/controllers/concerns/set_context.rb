module SetContext
  extend ActiveSupport::Concern

  def set_batch
    @batch = Batch.find(params[:batch_id]) if params[:batch_id]
  end

  def set_school
    @school = School.find(params[:school_id])
  end
end