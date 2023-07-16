class BatchesCourse < ApplicationRecord
    belongs_to :batch
    belongs_to :course
end
