module Api::V1
  class BaseController < ActionController::API
    include ::Api::Response
    include ::Api::ExceptionHandler

    # called before every action on controllers
    before_action :authorize_request
    attr_reader :current_user

    private

    # Check for valid request token and return user
    def authorize_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end
  end
end