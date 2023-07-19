class ProgressCard < ApplicationRecord
    belongs_to :batch
    belongs_to :student
    has_many :exam_evaluations
    accepts_nested_attributes_for :exam_evaluations

    enum :declaration, [:pass,:fail]
    
    #this method build score card for a student
    #If score is already available for a course then it is considered
    #If score is not available for a course then it is initialized to 0
    def build_score_card(student)
        available_scores = exam_evaluations.pluck(:course_id)
        unavailable_scores = student.current_batch.courses.pluck(:id) - available_scores
        unavailable_scores.each do |una_score|
          exam_evaluations.build(marks: 0, course_id: una_score)
        end
    end
end
