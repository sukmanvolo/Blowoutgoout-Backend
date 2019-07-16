module Api::V1
  class ClientsSignupController < ActionController::API
    include ::Api::Response
    include ::Api::ExceptionHandler

    def create
      @client = Client.new(client_params)
      @client.user.role = 'client'
      if @client.save
        CreateNotification.call(@client.user, notification_message)
        json_response(@client, :created)
      else
        json_response(@client.errors.messages, :unprocessable_entity)
      end
    end

    private

    def client_params
      params.require(:clients).permit(:facebook_id, :user_id, :image,
                                      user_attributes: [
                                        :first_name, :last_name, :phone,
                                        :id, :email, :password, :gcm_id,
                                        :device_type, :device_id]
                                      )
    end

    def notification_message
      "Your client account was created sucessfully!"
    end

  end
end