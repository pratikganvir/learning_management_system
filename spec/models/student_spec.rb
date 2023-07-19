require 'rails_helper'
include AuthHelper

  RSpec.describe Student, type: :model do

    before do
        FactoryBot.create(:login, :with_super_admin)
        @batch = FactoryBot.create(:batch, :with_student)
        @student = Student.find_by(school_id: @batch.school_id)
    end

    it 'returns list of classmates' do
        FactoryHelpers.add_classmate(@student,@batch)
        expect(@student.classmates.count).to be > 0
    end
  end