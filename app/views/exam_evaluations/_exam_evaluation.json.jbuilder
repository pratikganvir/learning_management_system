json.extract! exam_evaluation, :id, :course_id, :marks, :progress_card_id, :created_at, :updated_at
json.url exam_evaluation_url(exam_evaluation, format: :json)
