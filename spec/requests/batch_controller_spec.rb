require 'rails_helper'
include AuthHelper

  RSpec.describe BatchesController, type: :controller do
    describe 'Get :index' do

        before do
            @school = FactoryBot.create(:school, :with_admin_login)
        end

        it 'does not returns list of all batches for super admin user' do
            super_admin = FactoryBot.create(:login, :with_super_admin)
            login_user super_admin
            get :index, params: {school_id: @school.id}
            expect(response.code).to eq '302'
        end

        it 'returns list of all school admins for school admin user' do
            login_user @school.admin.login
            get :index, params: {school_id: @school.id}
            expect(response.code).to eq '200'
        end
    end
  end