module Api::V1
  class AvailabilitiesController < BaseController
    before_action :set_availability, only: [:show, :update, :destroy]

    # GET /availabilities
    def index
      services_count = service_ids && service_ids.count

      stylists = Stylist.nearest_stylists(params[:lat], params[:long])

      stylist_schedules = StylistSchedule
                                          .joins(:schedule)
                                          .where(schedules: { date: params[:date] })
                                          .where(stylist_schedules: { stylist_id: stylists })

      stylist_schedules = stylist_schedules.where(start_time: params[:start_time]) if params[:start_time]

      # filter by service_ids array
      stylist_schedules = stylist_schedules.reject { |sc| (sc.schedule.service_ids & service_ids).empty? } if service_ids

      # check if the schedule slot is available
      @available_schedules = []
      duration = Service.where(id: service_ids).pluck(:duration).max || 0
      stylist_schedules.each do |sc|
        sc.tmp_end_time = sc.start_time + duration.hours
        @available_schedules << sc if Booking.where(stylist_id: sc.stylist_id,
                                                    schedule_id: sc.schedule_id,
                                                    time_from: sc.start_time).empty?
      end

      render json: @available_schedules, each_serializer: AvailabilitySerializer, status: :ok
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
      if @availability.can_delete?
        @availability.destroy
        head :no_content
      else
        render json: { error: ['You can not remove current and next day schedules'] }, status: :unprocessable_entity
      end
    end

    private

    def availability_params
      params.require(:availabilities).permit(:schedule_id, :time_from, :time_to)
    end

    def set_availability
      @availability = Availability.find_by_id(params[:id])
    end

    def service_ids
      return params[:service_ids] unless params[:service_ids].is_a? String
      JSON.parse(params[:service_ids])
    end
  end
end
