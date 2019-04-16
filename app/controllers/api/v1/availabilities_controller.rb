module Api::V1
  class AvailabilitiesController < BaseController
    before_action :set_availability, only: [:show, :update, :destroy]
    before_action :set_data_params, only: [:index]

    # GET /availabilities
    def index
      @availabilities = Availability.free
      @availabilities = @schedule.availabilities.free if @schedule
      json_response(@availabilities)
    end

    # POST /availabilities
    def create
      @availability = Availability.new(availability_params)
      authorize @availability
      @availability.save!
      json_response(@availability, :created)
    end

    # GET /availabilities/:id
    def show
      json_response(@availability)
    end

    # PUT /availabilities/:id
    def update
      authorize @availability
      @availability.update(availability_params)
      head :no_content
    end

    # DELETE /availabilities/:id
    def destroy
      authorize @availability
      @availability.destroy
      head :no_content
    end

    private

    def availability_params
      params.require(:availabilities).permit(:schedule_id, :time_from, :time_to)
    end

    def set_availability
      @availability = Availability.find_by_id(params[:id])
    end

    def set_data_params
      @schedule = Schedule.find_by_id(params[:schedule_id])
    end
  end
end
