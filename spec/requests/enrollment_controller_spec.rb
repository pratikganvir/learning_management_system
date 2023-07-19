require 'rails_helper'
include AuthHelper

  RSpec.describe EnrollmentsController, type: :controller do
    describe 'POST :enrollment_verdict' do

        before do
            @enrollment = FactoryBot.create(:enrollment, :with_batch_student)
            @super_admin = FactoryBot.create(:login, :with_school_admin)
        end

        it 'can approve students enrollment request' do
            login_user @super_admin
            post :enrollment_verdict, params: {school_id: @enrollment.student_id,batch_id: @enrollment.batch_id,id: @enrollment.id,enrollment_action: 'approved'}
            @enrollment.reload
            expect(@enrollment.status).to eq 'approved'
            expect(response.code).to eq '302'
        end

        it 'can deny students enrollment request' do
            login_user @super_admin
            post :enrollment_verdict, params: {school_id: @enrollment.student_id,batch_id: @enrollment.batch_id,id: @enrollment.id,enrollment_action: 'denied'}
            @enrollment.reload
            expect(@enrollment.status).to eq 'denied'
            expect(response.code).to eq '302'
        end
    end
  end