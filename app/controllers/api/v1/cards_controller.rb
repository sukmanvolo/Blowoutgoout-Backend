module Api::V1
  class CardsController < BaseController
    before_action :set_client

    # GET cards
    def index
      @cards = @client && CardService.new(@client).list
      @cards = @cards && @cards.data || []
      json_response(@cards)
    end

    def create
      @card = @client && CardService.new(@client).create(params[:card_token])
      if card_has_error?
        json_response(@card)
      else
        json_response(@card, :unprocessable_entity)
      end
    end

    # DELETE cards/:id
    def destroy
      # authorize @card
      CardService.new(@client)&.delete(params[:card_token])
      head :no_content
    end

    private

    def set_client
      @client = current_user.client
    end

    def card_has_error?
      @card.class.name.downcase.include?('error')
    end
  end
end
