module Api::V1
  class AvailabilitiesController < BaseController

    # GET /availabilities
    def index
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
      duration = Service.where(id: service_ids).pluck(:duration).sum || 0
      stylist_schedules.each do |sc|
        sc.tmp_end_time = sc.start_time + duration.hours
        @available_schedules << sc if Booking.where(stylist_id: sc.stylist_id,
                                                    schedule_id: sc.schedule_id,
                                                    time_from: sc.start_time).empty?
      end

      render json: @available_schedules, each_serializer: AvailabilitySerializer, status: :ok
    end

    private

    def service_ids
      return params[:service_ids].map(&:to_i) unless params[:service_ids].is_a? String
      JSON.parse(params[:service_ids])
    end
  end
end
