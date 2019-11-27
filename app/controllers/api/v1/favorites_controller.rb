module Api::V1
  class FavoritesController < BaseController
    before_action :set_favorite, only: [:destroy]

    # GET /favorites
    def index
      @favorites = Favorite.all
      @favorites = @favorites.by_client(params[:client_id]) if params[:client_id]
      @stylists = Stylist.where(id: @favorites.pluck(:stylist_id))
      render json: @stylists, each_serializer: FavoriteSerializer, status: :ok
      # json_response(@stylists)
    end

    # POST /favorites
    def create
      @favorite = Favorite.new(favorite_params)
      authorize @favorite
      @favorite.save!
      # json_response(@favorite, :created)
      @stylists = Stylist.where(id: @favorite.stylist_id)
      render json: @stylists, each_serializer: FavoriteSerializer, status: :created
    end

    # DELETE /favorites/:id
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
      @favorite = Favorite.find_by(client_id: current_user.client.id, stylist_id: params[:id])
    end
  end
end
