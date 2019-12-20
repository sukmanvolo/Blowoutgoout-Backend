module Api::V1
  class UsersController < BaseController
    def index
      authorize User
      json_response(User.all)
    end
  end
end
