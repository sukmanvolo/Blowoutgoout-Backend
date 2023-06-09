class AuthenticateUser
  prepend SimpleCommand
  attr_reader :email, :password, :role, :facebook

  def initialize(email, password, role, facebook=false)
    @email = email
    @password = password
    @role = role
    @facebook = facebook
  end

  # Service entry point
  def call
    JsonWebToken.encode(payload) if user
  end

  private

  # verify user credentials
  def user
    user = User.find_by(email: email, role: role) if User::ROLE_OPTIONS.include? role
    return user if user&.authenticate(password) || facebook

    # raise Authentication error if credentials are invalid
    raise(Api::ExceptionHandler::AuthenticationError, ErrorMessage.invalid_credentials)
  end

  def payload
    if user.role != 'admin'
      { user_id: user.id, id: user.send(user.role).id, role: user.role,
        first_name: user.first_name, last_name: user.last_name,
        profile_pic: user_image
      }
    else
      { user_id: user.id, role: user.role }
    end
  end

  def user_image
    if user.send(user.role).image_attached?
      Rails.application
           .routes
           .url_helpers
           .rails_representation_url(user.send(user.role).image.variant(resize: "100x100").processed)
    end
  end
end
