module Api::V1
  class ReviewsController < BaseController
    before_action :set_review, only: [:update, :destroy]

    # GET /stylists
    def index
      @reviews = reviews
      json_response(@reviews)
    end

    # GET /stylists/by_stylist
    def by_stylist
      @reviews = reviews.by_stylist(params[:stylist_id]) if params[:stylist_id]
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
      # return 'You are not authorized to perform that action'.as_json unless current_user.client? && @review.client_id == current_user&.client&.id
      authorize @review
      @review.destroy
      head :no_content
    end

    private

    def review_params
      params.require(:reviews).permit(:client_id, :stylist_id, :text, :rate)
    end

    def set_review
      @review = Review.find(params[:id])
    end

    def reviews
      if current_user.client?
        Review.by_client(current_user&.client&.id)
      elsif current_user.stylist?
        Review.by_stylist(current_user&.stylist&.id)
      end
    end
  end
end
