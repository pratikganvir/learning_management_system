class ExamEvaluation < ApplicationRecord
    belongs_to :progress_card
    belongs_to :course
end
