module Api::V1
  class AvailabilitiesController < BaseController
    before_action :set_availability, only: [:show, :update, :destroy]

    # GET /availabilities
    def index
      services_count = service_ids && service_ids.count

      stylists = Stylist.nearest_stylists(params[:lat], params[:long])

      # puts "*** stylists: #{stylists.inspect}"

      stylist_schedules = StylistSchedule
                                          .joins(:schedule)
                                          .where(stylist_id: stylists,
                                                 start_time: params[:start_time],
                                                 schedule: params[:schedule_id]
                                                 )

      puts "*** stylist_schedules: #{stylist_schedules.inspect}"
      puts "*** Schedule: #{Schedule.find(params[:schedule_id]).inspect}"
      service_ids && service_ids.each do |service_id|
        stylist_schedules = StylistSchedule.joins(:schedule).where("schedules.service_ids @> ?", "{#{service_id}}")
      end

      # check services count
      stylist_schedules = stylist_schedules.reject{ |sc| sc.schedule.service_ids.count != services_count } if service_ids

      # filter by date range
      # stylist_schedules = stylist_schedules.reject{ |sc| sc.schedule.date > params[:from_date] } if params[:from_date]
      # stylist_schedules = stylist_schedules.reject{ |sc| sc.schedule.date <= params[:to_date] } if params[:to_date]

      # check if the schedule slot is available
      @available_schedules = []
      stylist_schedules.each do |sc|
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
