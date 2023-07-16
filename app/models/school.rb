class School < ApplicationRecord
    belongs_to :admin
    has_many :courses
    has_many :students
    has_many :batches

    validates :name, uniqueness: true
end
