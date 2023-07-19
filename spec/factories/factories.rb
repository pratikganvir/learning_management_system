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
        after(:create) do |student|
          create(:login, email: 'teststudent@testlms.com', password: 'test123', loginable_id: student.id, loginable_type: 'Student')
        end
      end

    end

    factory :school do
      name {'Year 2023'}
      address {'Test address'}
      contact_number {'9999999999'}
      email {'school@testlms.com'}
      
      trait :with_admin do
        before(:create) do |school|
          admin = create(:admin, admin_type: 'school_admin')
          school.admin_id = admin.id
        end
      end

      trait :with_admin_login do
        before(:create) do |school|
          login = create(:login, :with_school_admin)
          school.admin_id = login.loginable_id
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
        email {'test_schooladmin@testlms.com'}
        password {'test123'}
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

    factory :batch do
      name {'Year 2023'}
      start_date {'01-06-2023'}
      end_date {'01-03-2022'}
      status {'enrollment_open'}

      trait :with_student do
        before(:create) do |batch|
          student = create(:student, :with_school)
          batch.school_id = student.school_id
        end
      end
    end

    factory :enrollment do
      student_id { nil }
      batch_id { nil }
      status { 'requested' }

      trait :with_batch_student do
        before(:create) do |enrollment|
          batch = create(:batch, :with_student)
          enrollment.student_id = Student.where(school_id: batch.school_id).first.id
          enrollment.batch_id=batch.id
        end
      end
    end
  end 