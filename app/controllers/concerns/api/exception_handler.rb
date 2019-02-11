module Api::ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class UserNoValid < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class CredentialError < StandardError; end
  class InvalidTransactionAction < StandardError; end
  class InvalidRole < StandardError; end

  included do
    # Define custom handlers
    rescue_from Api::ExceptionHandler::UserNoValid, with: :user_no_valid
    rescue_from Api::ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from Api::ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from Api::ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from Api::ExceptionHandler::CredentialError, with: :unauthorized_request
    rescue_from Api::ExceptionHandler::InvalidTransactionAction, with: :invalid_transaction_action
    rescue_from Api::ExceptionHandler::InvalidRole, with: :role_does_not_exist
    rescue_from ActionController::RoutingError, with: :four_zero_four
    # rescue_from ActiveRecord::RecordNotFound, with: :four_zero_four
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end

  private

  # JSON response with message; Status code 404 - not found
  def four_zero_four(e)
    json_response({ message: e.message }, :not_found)
  end

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end

  def invalid_transaction_action(e)
    json_response({ message: e.message }, :unauthorized)
  end

  def user_no_valid
    json_response({ message: 'Invalid User' }, :unauthorized)
  end

  def user_not_authorized
    json_response({ message: 'You are not authorized to perform this action.' }, :unauthorized)
  end

  def role_does_not_exist(e)
    json_response({ message: e.message }, :unauthorized)
  end
end
