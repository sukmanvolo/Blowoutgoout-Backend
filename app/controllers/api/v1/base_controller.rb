module Api::V1
  class BaseController < ActionController::API
    include ::Api::Response
    include Api::ExceptionHandler
    include Pundit

    # called before every action on controllers
    before_action :authorize_request
    attr_reader :current_user, :current_role

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def authorization_data
      @auth ||= AuthorizeApiRequest.new(request.headers).call
    end

    # Check for valid request token and return user
    def authorize_request
      @current_user = authorization_data[:user]
    end

    def current_role
      @current_role = authorization_data[:role]
    end

    def user_not_authorized(exception)
      json_response({ message: 'You are not authorized to perform this action.' }, :unauthorized)
    end

    def per_page
      params[:per_page].presence || 20
    end

    def page_number
      params[:page].presence || 1
    end
  end
end