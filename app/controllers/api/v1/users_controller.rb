class Api::V1::UsersController < Api::V1::BaseController
  def index
    json_response(User.all)
  end
end
