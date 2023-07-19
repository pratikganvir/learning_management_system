require 'rails_helper'
include AuthHelper

  RSpec.describe StudentsController, type: :controller do

    before do
        FactoryBot.create(:login, :with_super_admin)
        @batch = FactoryBot.create(:batch, :with_student)
        @student = Student.find_by(school_id: @batch.school_id)
    end

    describe 'POST :request_enrollment' do

        it 'can request enrollment for a batch' do
            login_user @student.login
            put :request_enrollment, params: {"batch_id"=>@batch.id, "school_id"=>@batch.school_id, "id"=>@student.id}
            expect(Enrollment.exists?(student_id: @student.id, batch_id: @batch.id, status: 'requested')).to be true
            expect(response).to redirect_to(enrollments_school_student_path(school_id: @batch.school_id, id: @student.id))
        end

    end

    describe 'GET :classmates' do

        it 'can see classmates' do
            FactoryHelpers.add_classmate(@student,@batch)
            login_user @student.login
            get :classmates, params: {"batch_id"=>@batch.id, "school_id"=>@batch.school_id, "id"=>@student.id}
            expect(response.code).to eq('200') 
        end
    end
  end