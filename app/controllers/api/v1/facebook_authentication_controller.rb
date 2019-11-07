module Api::V1
  class FacebookAuthenticationController < Api::V1::BaseController
    skip_before_action :authorize_request

    before_action :authenticate

    def create
      command = AuthenticateUser.call(entity.email, nil, 'client', true)

      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end

    private

    def authenticate
      unless entity.present?
        # raise Authentication error if credentials are invalid
        raise(Api::ExceptionHandler::AuthenticationError, ErrorMessage.invalid_credentials)
      end
    end

    def entity
      @entity ||=
        if FacebookService.valid_token?(params[:access_token])
          data = FacebookService.fetch_data(params[:access_token])
          picture_url = data['picture'] && data['picture']['data'] && data['picture']['data']['url']

          pass = SecureRandom.alphanumeric
          user = User.find_or_create_by(email: data['email']) do |user|
            user.first_name = data['first_name']
            user.last_name = data['last_name']
            user.email = data['email']
            user.role = 'client'
            user.password = pass
            user.password_confirmation = pass
          end

          require "down"

          if user.client
            # // TODO: update profile picture
          else
            tmp_image = tempfile = Down.download(picture_url)
            client = user.build_client
            client.image.attach(
              io: File.open(tmp_image.path),
              filename: tmp_image.original_filename,
              content_type: tmp_image.content_type
            )
          end
          user.save
          user
        end
    end

  end
end