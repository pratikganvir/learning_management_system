class Batch < ApplicationRecord
    has_many :batches_courses
    has_many :courses, through: :batches_courses
    has_many :progress_cards
    has_many :enrollments
    accepts_nested_attributes_for :batches_courses, allow_destroy: true

    enum :status, [:inactive, :enrollment_open, :enrollment_closed]

    validates :name, uniqueness: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :status, presence: true

    def assign_courses(course_ids)
        batches_courses_association_params = course_ids.map {|course_id| {course_id: course_id } }
        batches_courses.create(batches_courses_association_params)
    end
end