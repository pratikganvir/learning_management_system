require 'rails_helper'
include AuthHelper

  RSpec.describe SchoolsController, type: :controller do
    describe 'Get :index' do
        
        it 'returns list of all schools for super admin user' do
            login_user_role('super_admin')
            get :index
            expect(response.code).to eq '200'
        end

        it 'does not return list of all schools for school admin user' do
            login_user_role('school_admin')
            get :index
            expect(response.code).to eq '302'
        end

        it 'does not return list of all schools for student' do
            login_user_role('student')
            get :index
            expect(response.code).to eq '302'
        end
    end

    describe 'POST :create' do

        before do
            @school_valid_attributes = FactoryBot.build(:school, name: 'Test School',email: 'test_school@testlms.com').attributes
            @duplicate_school_attributes = FactoryBot.build(:school, name: 'Test School',email: 'test_school@testlms.com').attributes
        end

        it 'can create a school by super admin user' do
            super_admin = FactoryBot.create(:login, :with_super_admin)
            login_user super_admin
            post 'create', params: {school: @school_valid_attributes}
            school = School.where(name: @school_valid_attributes['name'], email: @school_valid_attributes['email']).first
            expect(response).to redirect_to(school_path(school))
        end

        it 'can not create a school by school admin user' do
            school_admin = FactoryBot.create(:login, :with_school_admin)
            login_user school_admin
            post 'create', params: {school: @school_valid_attributes}
            expect(response.code).to eq('302')
        end

        it 'can not create a school by student' do
            student = FactoryBot.create(:login, :with_student)
            login_user student
            post 'create', params: {school: @school_valid_attributes}
            expect(response.code).to eq('302')
        end

        it 'can not create a school with same name and email address' do
            student = FactoryBot.create(:login, :with_student)
            login_user student
            post 'create', params: {school: @school_valid_attributes}
            post 'create', params: {school: @duplicate_school_attributes}
            expect(response.code).to eq('422')
        end

    end

    describe 'PUT :update' do

        before do
            @school = FactoryBot.create(:school, name: 'Test School',email: 'test_school@testlms.com')
            @update_attributes = {name: 'Test School Updated'}
        end

        it 'can update a school information by super admin user' do
            super_admin = FactoryBot.create(:login, :with_super_admin)
            login_user super_admin
            patch 'update', params: {id: @school.id, school: @update_attributes}
            expect(response).to redirect_to(school_path(id: @school.id))
        end

        it 'can not update a school information by school admin user' do
            school_admin = FactoryBot.create(:login, :with_school_admin)
            login_user school_admin
            patch 'update', params: {id: @school.id, school: @update_attributes}
            expect(response).to redirect_to(root_path)
        end

        it 'can not update a school information by student user' do
            FactoryBot.create(:login, :with_super_admin)
            student = FactoryBot.create(:login, :with_student)
            login_user student
            patch 'update', params: {id: @school.id, school: @update_attributes}
            expect(response).to redirect_to(root_path)
        end

    end

    describe 'DELETE :destroy' do

        before do
            @school = FactoryBot.create(:school, name: 'Test School',email: 'test_school@testlms.com')
        end

        it 'can delete a school by super admin user' do
            super_admin = FactoryBot.create(:login, :with_super_admin)
            login_user super_admin
            delete 'destroy', params: {id: @school.id}
            expect(School.exists?(id: @school.id)).to be false
            expect(response).to redirect_to(schools_path)
        end

        it 'can delete a school by school admin user' do
            school_admin = FactoryBot.create(:login, :with_school_admin)
            login_user school_admin
            delete 'destroy', params: {id: @school.id}
            expect(School.exists?(id: @school.id)).to be true
            expect(response.code).to eq('302')
        end

        it 'can delete a school by student' do
            FactoryBot.create(:login, :with_super_admin)
            student = FactoryBot.create(:login, :with_student)
            login_user student
            delete 'destroy', params: {id: @school.id}
            expect(School.exists?(id: @school.id)).to be true
            expect(response.code).to eq('302')
        end

    end
  end