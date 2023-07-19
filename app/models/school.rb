class School < ApplicationRecord
    belongs_to :admin, required: false
    has_many :courses
    has_many :students
    has_many :batches

    validates :name, uniqueness: {scope: :email}
end
