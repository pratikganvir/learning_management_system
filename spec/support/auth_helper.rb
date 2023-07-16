require 'spec_helper'

module AuthHelper
 def login_user(user)
  @request.env["devise.mapping"] = Devise.mappings[:login]
  user = if user=='super_admin'
     create(:login, :with_super_admin)
  elsif user=='school_admin'
    create(:login, :with_school_admin)
  elsif user=='student'
    create(:login, :with_super_admin)
    create(:login, :with_student)
  end
  # user.confirm # or set a confirmed_at inside the factory. Only      necessary if you are using the "confirmable" module
  sign_in user
 end
end