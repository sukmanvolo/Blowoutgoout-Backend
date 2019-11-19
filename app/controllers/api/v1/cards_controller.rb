module Api::V1
  class CardsController < BaseController
    before_action :set_client, only: [:index, :destroy]

    # GET cards
    def index
      @cards = @client && CardService.new(@client).list
      @cards = @cards && @cards.data || []
      json_response(@cards)
    end

    def create
      @card = @client && CardService.new(@client).create
      if @card
        json_response(@card)
      else
        ## show errors
      end
    end

    # DELETE cards/:id
    def destroy
      authorize @card
      CardService.new(@client)&.delete(params[:card_token])
      head :no_content
    end

    private

    def set_client
      current_user.client.id
    end
  end
end
