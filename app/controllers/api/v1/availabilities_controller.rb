module Api::V1
  class AvailabilitiesController < BaseController

    # GET /availabilities
    def index
      distance = params[:distance] || 25
      stylists = Stylist.nearest_stylists(distance, params[:lat], params[:long])

      stylist_schedules = StylistSchedule
                                          .joins(:schedule)
                                          .where(schedules: { date: params[:date] })
                                          .where(stylist_schedules: { stylist_id: stylists, available: true })

      stylist_schedules = stylist_schedules.where(start_time: params[:start_time]) if params[:start_time]

      # filter by service_ids array
      stylist_schedules = stylist_schedules.reject { |sc| (sc.schedule.service_ids & service_ids).empty? } if service_ids

      # check if the schedule slot is available
      @available_schedules = []
      duration = Service.where(id: service_ids).pluck(:duration).sum || 0
      stylist_schedules.each do |sc|
        sc.tmp_end_time = sc.start_time + duration.hours
        @available_schedules << sc
      end

      render json: @available_schedules, each_serializer: AvailabilitySerializer, status: :ok
    end

    # GET /availabilities/by_stylist
    def by_stylist
      @stylist_schedules = StylistSchedule
                              .joins(:schedule)
                              .where(stylist_schedules: {stylist_id: params[:stylist_id], available: true})

      json_response(@stylist_schedules)
    end

    private

    def service_ids
      return params[:service_ids].map(&:to_i) unless params[:service_ids].is_a? String
      JSON.parse(params[:service_ids])
    end
  end
end
