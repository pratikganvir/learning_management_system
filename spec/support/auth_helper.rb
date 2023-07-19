require 'spec_helper'

module AuthHelper
 def login_user(user)
  @request.env["devise.mapping"] = Devise.mappings[:login]
  sign_in user
 end

 def login_user_role(role)
  @request.env["devise.mapping"] = Devise.mappings[:login]
  login = if role=='super_admin'
     create(:login, :with_super_admin)
  elsif role=='school_admin'
    create(:login, :with_school_admin)
  elsif role=='student'
    create(:login, :with_super_admin)
    create(:login, :with_student)
  end
  sign_in login
 end
end