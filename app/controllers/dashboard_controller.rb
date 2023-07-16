class DashboardController < ApplicationController
  def home
      @school = current_login.loginable.school
      @student = current_login.loginable if current_login.student?
  end
end
