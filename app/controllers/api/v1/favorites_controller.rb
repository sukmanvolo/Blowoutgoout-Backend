module Api::V1
  class FavoritesController < BaseController
    before_action :set_favorite, only: [:destroy]

    # GET /stylists
    def index
      @favorites = Favorite.all
      @favorites = @favorites.by_client(client) if client
      @favorites = Stylist.where(id: @favorites.pluck(:stylist_id))
      json_response(@favorites)
    end

    # POST /stylists
    def create
      @favorite = Favorite.new(favorite_params)
      authorize @favorite
      @favorite.save!
      json_response(@favorite, :created)
    end

    # DELETE /stylists/:id
    def destroy
      authorize @favorite
      @favorite.destroy
      head :no_content
    end

    private

    def favorite_params
      params.require(:favorites).permit(:client_id, :stylist_id)
    end

    def set_favorite
      @favorite = Favorite.find_by_id(params[:id])
    end

    def client
      id = params[:favorites] && params[:favorites][:client_id]
      @client ||= Client.find_by_id(id)
    end
  end
end
