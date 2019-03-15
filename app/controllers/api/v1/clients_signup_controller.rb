module Api::V1
  class ClientsSignupController < ActionController::API
    include ::Api::Response
    include ::Api::ExceptionHandler

    def create
      @client = Client.create!(client_params)
      json_response(@client, :created)
    end

    private

    def client_params
      params.require(:clients).permit(:facebook_id, :user_id, :image,
                                      user_attributes: [
                                        :first_name, :last_name, :phone,
                                        :id, :email, :password, :role, :gcm_id,
                                        :device_type, :device_id]
                                      )
    end
  end
end