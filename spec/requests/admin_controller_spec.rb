require 'rails_helper'
include AuthHelper

  RSpec.describe AdminsController, type: :controller do
    describe 'Get :index' do
        
        it 'returns list of all school admins for super admin user' do
            login_user_role('super_admin')
            get :index
            expect(response.code).to eq '200'
        end

        it 'does not return list of all school admins for school admin user' do
            login_user_role('school_admin')
            get :index
            expect(response.code).to eq '302'
        end

        it 'does not return list of all school admins for student' do
            login_user_role('student')
            get :index
            expect(response.code).to eq '302'
        end
    end

    describe 'POST :create' do

        before do
            @school_admin_valid_attributes = FactoryBot.build(:admin,admin_type: 'school_admin').attributes
            login_school_admin_valid_attributes = FactoryBot.build(:login,email: 'school_admin@testlms.com').attributes
            @school_admin_valid_attributes = {admin: @school_admin_valid_attributes, login_attributes: login_school_admin_valid_attributes }
            @admin_finder_attributes = {first_name: @school_admin_valid_attributes[:admin]['first_name'], 
                                        last_name: @school_admin_valid_attributes[:admin]['last_name'], 
                                        admin_type: @school_admin_valid_attributes[:admin]['admin_type']}
            
        end

        it 'can create a school admin by super admin user' do
            super_admin = FactoryBot.create(:login, :with_super_admin)
            login_user super_admin
            post 'create', params: @school_admin_valid_attributes
            school_admin = Admin.where(@admin_finder_attributes).first
            expect(response).to redirect_to(admin_path(school_admin))
        end

        it 'can not create a school admin by school admin user' do
            school_admin = FactoryBot.create(:login, :with_school_admin)
            login_user school_admin
            post 'create', params: @school_admin_valid_attributes
            expect(response).to redirect_to(root_path)
        end

        it 'can not create a school admin by student user' do
            FactoryBot.create(:login, :with_super_admin)
            student_login = FactoryBot.create(:login, :with_student)
            login_user student_login
            post 'create', params: @school_admin_valid_attributes
            expect(response).to redirect_to(root_path)
        end

    end

    describe 'PUT :update' do

        before do
            @super_admin = FactoryBot.create(:login, :with_super_admin)
            @school_admin = FactoryBot.create(:login, :with_school_admin, email: 'school_admin2@testlms.com')
            @student_login = FactoryBot.create(:login, :with_student)
            @school_admin_valid_attributes = FactoryBot.build(:admin,admin_type: 'school_admin').attributes
            login_school_admin_valid_attributes = FactoryBot.build(:login,email: 'school_admin@testlms.com').attributes
            @school_admin_valid_attributes = {admin: @school_admin_valid_attributes, login_attributes: login_school_admin_valid_attributes }
            @school_admin_valid_attributes.merge(id: @school_admin.id)
        end

        it 'can update a school admin by super admin user' do
            login_user @super_admin
            patch 'update', params: @school_admin_valid_attributes.merge(id: @school_admin.id)
            expect(response).to redirect_to(admin_path(id: @school_admin.id))
        end

        it 'can not update a school admin by school admin user' do
            login_user @school_admin
            patch 'update', params: @school_admin_valid_attributes.merge(id: @school_admin.id)
            expect(response).to redirect_to(root_path)
        end

        it 'can not update a school admin by student user' do
            login_user @student_login
            patch 'update', params: @school_admin_valid_attributes.merge(id: @school_admin.id)
            expect(response).to redirect_to(root_path)
        end

    end

    describe 'DELETE :destroy' do

        before do
            @super_admin = FactoryBot.create(:login, :with_super_admin)
            @super_admin2 = FactoryBot.create(:login, :with_super_admin, email: 'super_admin2@testlms.com')
        end

        it 'can not delete admin user' do
            login_user @super_admin
            delete 'destroy', params: {id: @super_admin2.id}
            expect(response.code).to eq('302')
        end

    end
    
  end