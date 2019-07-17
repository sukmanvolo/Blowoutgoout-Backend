module Api::V1
  class ClientsController < BaseController
    before_action :set_client, only: [:show, :update, :destroy]

    # GET /clients
    def index
      @clients = Client.all
      authorize @clients
      json_response(@clients)
    end

    # POST /clients only for admin
    def create
      @client = Client.new(client_params)
      authorize @client
      @client.save!
      json_response(@client, :created)
    end

    # GET /clients/:id
    def show
      json_response(@client)
    end

    # PUT /clients/:id
    def update
      authorize @client
      client_data = client_params
      user_data = client_data.delete :user_attributes
      @client.user.update(user_data)
      if @client.update(client_data)
        json_response(@client, :accepted)
      else
        json_response(@client.errors.messages, :unprocessable_entity)
      end
    end

    # DELETE /clients/:id
    def destroy
      authorize @client
      @client.destroy
      head :no_content
    end

    private

    def client_params
      params.require(:clients).permit(:facebook_id, :user_id, :customer_id, :image,
                                      user_attributes: [
                                        :first_name, :last_name, :phone,
                                        :email, :password, :gcm_id,
                                        :device_type, :device_id]
                                      )
    end

    def set_client
      @client = Client.find(params[:id])
    end

    def user_attributes
      client_params.delete :user_attributes
    end
  end
end
