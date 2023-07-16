FactoryBot.define do
    factory :admin do
      first_name { 'Super' }
      last_name  { 'Admin' }
      admin_type { 'super_admin' }
    end

    factory :student do
      first_name { 'John' }
      middle_name { 'M' }
      last_name { 'Doe' }
      date_of_birth  { Date.new(1980,6,10) }
      gender { 'Male' }

      trait :with_school do
        before(:create) do |student|
          school = create(:school, :with_admin)
          student.school_id = school.id
        end
      end
    end

    factory :school do
      name { 'John' }
      address { 'M' }
      contact_number { 'Doe' }
      email  { Date.new(1980,6,10) }
      
      trait :with_admin do
        before(:create) do |school|
          admin = create(:admin, admin_type: 'school_admin')
          school.admin_id = admin.id
        end
      end
    end

    factory :login do
      email { 'superadmin@testlms..com' }
      password { 'test123' }

      trait :with_super_admin do
        before(:create) do |login|
          admin_user = create(:admin)
          login.loginable_id = admin_user.id
          login.loginable_type = 'Admin'
        end
      end

      trait :with_school_admin do
        before(:create) do |login|
          admin_user = create(:admin, admin_type: 'school_admin')
          login.loginable_id = admin_user.id
          login.loginable_type = 'Admin'
        end
      end

      trait :with_student do
        email {'student@testlms.com'}
        password {'test123'}
        before(:create) do |login|
          admin_user = create(:student, :with_school)
          login.loginable_id = admin_user.id
          login.loginable_type = 'Student'
        end
      end
    end
  end 