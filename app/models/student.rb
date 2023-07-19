class Student < ApplicationRecord
    belongs_to :school
    belongs_to :batch, optional: true
    has_one :login, as: :loginable
    has_many :enrollments
    has_many :progress_cards
    accepts_nested_attributes_for :login, allow_destroy: true

    validates :first_name, presence: true
    validates :middle_name, presence: true
    validates :last_name, presence: true
    validates :date_of_birth, presence: true
    validates :gender, presence: true

    validate :student_age

    enum :gender, ['Female', 'Male']

    def full_name
        "#{first_name} #{middle_name} #{last_name}"
    end

    def enrollment_request_status(batch_id)
        enrollments.find_by(batch_id: batch_id).try(:status)
    end

    def enrollment_requested?(course_id)
        enrollments.exists?(course_id: course_id)
    end

    def current_batch
        enrollments.find_by(status: Enrollment.statuses[:approved]).try :batch
    end

    def classmates
        Student.where(id: Enrollment.where(batch_id: current_batch.id).where.not(student_id: id).pluck(:student_id))
    end

    private

    def student_age
        if (Date.today - date_of_birth) < 1095
            errors.add(:base, 'Student must be atleast 3 Years old')
        end
    end
    
end
