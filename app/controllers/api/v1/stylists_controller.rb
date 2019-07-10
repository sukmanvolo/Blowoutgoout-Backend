module Api::V1
  class StylistsController < BaseController
    before_action :set_stylist, only: [:show, :update, :destroy]

    # GET /stylists
    def index
      @stylists = Stylist.all
      json_response(@stylists)
    end

    # POST /stylists
    def create
      @stylist = Stylist.new(stylist_params)
      authorize @stylist
      @stylist.save!
      json_response(@stylist, :created)
    end

    # GET /stylists/:id
    def show
      render json: @stylist, serializer: ShowStylistSerializer, status: status
      # json_response(@stylist)
    end

    # PUT /stylists/:id
    def update
      authorize @stylist
      @stylist.update(stylist_params)
      head :no_content
    end

    # DELETE /stylists/:id
    def destroy
      authorize @stylist
      @stylist.destroy
      head :no_content
    end

    # GET /stylists/nearest_stylists
    def nearest_stylists
      @stylists = Stylist.nearest_stylists(params[:lat], params[:long])
      json_response(@stylists)
    end

    private

    def stylist_params
      params.require(:stylists).permit(:years_of_experience, :license_agreement,
                                       :has_smartphone, :has_transportation,
                                       :portfolio_link, :is_eligible_to_work_in_us,
                                       :previous_contractor_date, :has_conviction,
                                       :agrees_to_unemployment_understanding,
                                       :agrees_to_taxation_understanding,
                                       :status, :description, :welcome_kit,
                                       :lat, :long, :user_id, :radius, :image)
    end

    def set_stylist
      @stylist = Stylist.find(params[:id])
    end
  end
end
