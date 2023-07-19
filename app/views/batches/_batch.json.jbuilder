json.extract! batch, :id, :name, :start_date, :end_date, :created_at, :updated_at
json.url school_batch_url(@school,@batch, format: :json)
