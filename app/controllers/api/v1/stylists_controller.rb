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
      params.require(:stylists).permit(:name, :service_type, :status, :first_name,
                                       :last_name, :description, :phone, :welcome_kit,
                                       :lat, :long, :user_id, :radius)
    end

    def set_stylist
      @stylist = Stylist.find(params[:id])
    end
  end
end
