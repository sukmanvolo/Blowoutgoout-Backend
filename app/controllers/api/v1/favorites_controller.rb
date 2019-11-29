module Api::V1
  class FavoritesController < BaseController
    before_action :set_favorite, only: [:destroy]

    # GET /favorites
    def index
      @favorites = Favorite.all
      @favorites = current_user.client.favorites #@favorites.by_client(params[:client_id]) if params[:client_id]
      @stylists = Stylist.where(id: @favorites.pluck(:stylist_id))
      render json: @stylists, each_serializer: ShowStylistSerializer, status: :ok
      # json_response(@stylists)
    end

    # POST /favorites
    def create
      @favorite = current_user.client.favorites.find_or_create_by(stylist_id: favorite_params[:stylist_id])
      authorize @favorite
      @favorite.save!
      # json_response(@favorite, :created)
      render json: @favorite, each_serializer: ShowStylistSerializer, status: :created
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
