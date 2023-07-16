class Enrollment < ApplicationRecord
    enum :status, [:requested, :approved, :denied, :completed]
    belongs_to :batch
    belongs_to :student

    validates :batch_id, uniqueness: { scope: :student_id }
end
