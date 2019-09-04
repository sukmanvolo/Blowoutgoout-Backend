module Api::V1
  class ServicesController < BaseController
    before_action :set_service, only: [:show, :update, :destroy]

    # GET /services
    def index
      @services = Service.all
      @services = @services.where(service_type_id: service_type_id) if service_type_id
      json_response(@services)
    end

    # POST /services
    def create
      @service = Service.new(service_params)
      authorize @service
      @service.save!
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

    # GET /services/nearest_services
    def nearest_services
      @services = FilterNearestServices.call(params[:lat],
                                             params[:long],
                                             params[:service_type_id]).result.uniq
      json_response(@services)
    end

    private

    def service_params
      params.require(:services).permit(:name, :status, :service_type_id,
                                       :amount, :duration, :image)
    end

    def set_service
      @service = Service.find_by_id(params[:id])
    end

    def service_type_id
      params[:service_type]
    end
  end
end
