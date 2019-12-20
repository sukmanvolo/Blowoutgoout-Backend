class Api::V1::AuthenticationController < Api::V1::BaseController
  skip_before_action :authorize_request

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password], params[:role])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
