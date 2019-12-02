module Api::V1
  class ReviewsController < BaseController
    before_action :set_review, only: [:update, :destroy]

    # GET /stylists
    def index
      # @reviews = Review.all
      json_response(@reviews)
    end

    # GET /stylists/by_stylist
    def by_stylist
      @reviews = Review.by_stylist(params[:stylist_id]) if params[:stylist_id]
      json_response(@reviews)
    end

    # GET /stylists/by_client
    def by_client
      @reviews = Review.by_client(params[:client_id]) if params[:client_id]
      json_response(@reviews)
    end

    # POST /stylists
    def create
      @review = Review.new(review_params)
      authorize @review
      @review.save!
      json_response(@review, :created)
    end

    def update
      # @review.update
    end

    # DELETE /stylists/:id
    def destroy
      authorize @review
      @review.destroy
      head :no_content
    end

    private

    def review_params
      params.require(:reviews).permit(:client_id, :stylist_id, :text, :rate)
    end

    def set_review
      @favorite = Review.find(params[:id])
    end
  end
end
