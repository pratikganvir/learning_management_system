require 'rails_helper'
include AuthHelper

  RSpec.describe AdminsController, type: :controller do
    describe 'index' do
        
        it 'returns list of all school admins for super admin user' do
            login_user('super_admin')
            get :index
            expect(response.code).to eq '200'
        end

        it 'does not return list of all school admins for school admin user' do
            login_user('school_admin')
            get :index
            expect(response.code).to eq '302'
        end

        it 'does not return list of all school admins for student' do
            login_user('student')
            get :index
            expect(response.code).to eq '302'
        end
    end
  end