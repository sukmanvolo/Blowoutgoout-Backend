module Api::V1
  class ClientsController < BaseController
    before_action :set_client, only: [:show, :update, :destroy]

    # GET /clients
    def index
      @clients = Clients.all
      json_response(@clients)
    end

    # POST /clients
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
      @client.update(client_params)
      head :no_content
    end

    # DELETE /clients/:id
    def destroy
      authorize @client
      @client.destroy
      head :no_content
    end

    private

    def client_params
      params.require(:clients).permit(:facebook_id, :user_id, :customer_id, :image)
    end

    def set_client
      @client = Client.find(params[:id])
    end
  end
end
