module Api::V1
  class FacebookUserTokenController < ActionController::API

    before_action :authenticate

    def create
      render json: auth_token, status: :created
    end

    private

    def authenticate
      # unless entity.present?
      #   puts "**** Error Not record found"
      #   # raise Knock.not_found_exception_class
      # end
    end

    def auth_token
      puts "**** generar y Devolver token"
      # if entity.respond_to? :to_token_payload
      #   Knock::AuthToken.new payload: entity.to_token_payload
      # else
      #   Knock::AuthToken.new payload: { sub: entity.id }
      # end
    end

    def entity
      @entity ||=
        if FacebookService.valid_token?(params[:access_token])
          data = FacebookService.fetch_data(params[:access_token])
          puts "*** Crear o Devolver user"
          # User.find_or_create_by uid: data['id'] do |user|
          #   user.first_name = data['first_name']
          #   user.last_name = data['last_name']
          #   user.email = data['email']
          # end
        end
    end

    def auth_params
      params[:access_token]
      # params.require(:auth).permit :access_token
    end

  end
end