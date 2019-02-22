module Api::V1
  class ServicesController < BaseController
    before_action :set_service, only: [:show, :update, :destroy]

    # GET /services
    def index
      @services = Service.all
      json_response(@services)
    end

    # POST /services
    def create
      @service = Service.new(service_params)
      authorize @service
      @service = @service.save!
      json_response(@service, :created)
    end

    # GET /services/:id
    def show
      json_response(@service)
    end

    # PUT /services/:id
    def update
      authorize @service
      @service.update(service_params)
      head :no_content
    end

    # DELETE /services/:id
    def destroy
      authorize @service
      @service.destroy
      head :no_content
    end

    private

    def service_params
      params.require(:services).permit(:name, :service_type, :status, :service_type_id,
                                       :stylist_id, :amount, :service_id)
    end

    def set_service
      @service = Service.find(params[:id])
    end
  end
end
