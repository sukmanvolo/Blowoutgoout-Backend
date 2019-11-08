module Api::V1
  class CardsController < BaseController
    before_action :set_client, only: [:index, :destroy]

    # GET cards
    def index
      @cards = @client && CardService.new(@client).list
      @cards = @cards && @cards.data || []
      json_response(@cards)
    end

    # DELETE cards/:id
    def destroy
      authorize @card
      CardService.new(@client)&.delete(params[:card_token])
      head :no_content
    end

    private

    def set_client
      @client = Client.find_by_id(params[:client_id])
    end
  end
end
