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
      @client.user.update(user_data) if user_data
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

    def become_a_stylist
      @client = Client.find_by_id(params[:client_id])
      if @client
        @stylist = Stylist.new(stylist_params)
        @stylist.user.last_name = @client.user.last_name
        @stylist.user.password_digest = @client.user.password_digest
        @stylist.user.role = 'stylist'
        @stylist.user.gcm_id = @client.user.gcm_id
        @stylist.user.device_type = @client.user.device_type
        @stylist.user.device_id = @client.user.device_id
        @stylist.save
      else
        json_response(@client, :unprocessable_entity)
      end
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

    def stylist_params
      params.require(:stylists).permit(:years_of_experience, :license_agreement,
                                      :has_smartphone, :has_transportation,
                                      user_attributes: [
                                        :first_name, :email, :phone
                                        ]
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
