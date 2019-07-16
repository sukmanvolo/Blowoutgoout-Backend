module Api::V1
  class CardsController < BaseController
    before_action :set_payment, only: [:show, :update, :destroy]

    # GET cards
    def index
      @cards = CardService.new(client).list.data
      json_response(@cards)
    end

    # DELETE cards/:id
    def destroy
      authorize @card
      CardService.new(client).delete(card_token)
      head :no_content
    end

    private

    def card_params
      params.require(:cards).permit(:card_token)
    end

    def card_token
      params[:cards] && params[:cards][:card_token]
    end

    def client
      current_user.client
    end
  end
end
