class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: user.id, role: user.role) if user
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)

    # raise Authentication error if credentials are invalid
    raise(Api::ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
