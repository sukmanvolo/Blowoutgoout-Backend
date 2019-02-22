module Api::V1
  class ServiceTypesController < BaseController
    before_action :set_service_type, only: [:show, :update, :destroy]

    # GET /service_types
    def index
      @service_types = ServiceType.actives
      json_response(@service_types)
    end

    # POST /service_types
    def create
      @service_type = ServiceType.new(service_type_params)
      authorize @service_type
      @service_type.save!(service_type_params)
      json_response(@service_type, :created)
    end

    # GET /service_types/:id
    def show
      json_response(@service_type)
    end

    # PUT /service_types/:id
    def update
      authorize @service_type
      @service_type.update(service_type_params)
      head :no_content
    end

    # DELETE /service_types/:id
    def destroy
      authorize @service_type
      @service_type.destroy
      head :no_content
    end

    private

    def service_type_params
      params.require(:service_types).permit(:name, :status)
    end

    def set_service_type
      @service_type = ServiceType.find(params[:id])
    end
  end
end
