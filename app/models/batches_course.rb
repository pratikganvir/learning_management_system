class BatchesCourse < ApplicationRecord
    belongs_to :batch
    belongs_to :course

    validates :batch_id, uniqueness: { scope: :course_id }
end
