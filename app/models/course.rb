class Course < ApplicationRecord
    has_many :batches_courses
    validates :name, presence: true
    validates :description, presence: true
end
