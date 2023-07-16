json.extract! enrollment, :id, :student_id, :batch_id, :status, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)
