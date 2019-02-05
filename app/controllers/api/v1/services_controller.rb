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
      @service = Service.create!(service_params)
      json_response(@service, :created)
    end

    # GET /services/:id
    def show
      json_response(@service)
    end

    # PUT /services/:id
    def update
      @service.update(service_params)
      head :no_content
    end

    # DELETE /services/:id
    def destroy
      @service.destroy
      head :no_content
    end

    private

    def service_params
      params.permit(:name, :service_type)
    end

    def set_service
      @service = Service.find(params[:id])
    end
  end
end
