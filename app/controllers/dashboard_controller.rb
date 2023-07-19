class DashboardController < ApplicationController

  #This is root action
  #If any user (super_admin, school_admin, student) signs in, it lands to this page.
  def home
      @school = current_login.loginable.school
      @student = current_login.loginable if current_login.student?
  end
end
