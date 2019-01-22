# API V1 User controller
module Api
  module V1
    class UsersController < Api::V1::BaseController
      def index
        json_response(User.all)
      end
    end
  end
end
