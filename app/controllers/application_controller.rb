class ApplicationController < ActionController::Base
    include Pundit::Authorization
    before_action :authenticate_login!
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def pundit_user
        current_login
    end

    private

    def user_not_authorized
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to(request.referrer || root_path)
    end
end
