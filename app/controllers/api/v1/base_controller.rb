module Api::V1
  class BaseController < ActionController::API
    include ::Api::Response
    include ::Api::ExceptionHandler

    # called before every action on controllers
    before_action :authorize_request
    attr_reader :current_user, :current_role

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
  end
end