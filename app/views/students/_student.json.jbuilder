json.extract! student, :id, :first_name, :middle_name, :last_name, :date_of_birth, :gender, :created_at, :updated_at
json.url school_student_url(@school, @student, format: :json)
