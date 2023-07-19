class ApplicationController < ActionController::Base
    include Pundit::Authorization
    before_action :authenticate_login!, unless: :json_request?
    before_action :check_api_login!, if: :json_request?
    skip_before_action :verify_authenticity_token, if: :json_request?
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def pundit_user
        current_login
    end

    private

    def user_not_authorized
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to(request.referrer || root_path)
    end

    def json_request?
      request.format.json?
    end

    def check_api_login!
      render({status: 401, message: 'User unauthorized'}) unless (request.headers["username"]==USERNAME && request.headers["password"]==PASSWORD)
      login = Admin.where(admin_type: 'super_admin').first.try :login
      if login
        sign_in login
      else
        render(json: {status: 422, message: 'Super admin does not exist'})
      end
    end
end
