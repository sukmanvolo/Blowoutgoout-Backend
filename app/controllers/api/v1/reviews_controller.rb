module Api::V1
  class ReviewsController < BaseController
    before_action :set_review, only: [:destroy]

    # GET /stylists
    def index
      @reviews = Review.all
      @reviews = @reviews.by_stylist(params[:stylist_id]) if params[:stylist_id]
      @reviews = Stylist.where(id: @reviews.pluck(:stylist_id))
      json_response(@reviews)
    end

    # POST /stylists
    def create
      @favorite = Review.new(favorite_params)
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
      params.require(:reviews).permit(:client_id, :stylist_id, :text, :rate)
    end

    def set_review
      @favorite = Review.find_by_id(params[:id])
    end
  end
end
