module Api::V1
  class SchedulesController < BaseController
    before_action :set_schedule, only: [:show, :update, :destroy]

    # GET /schedules
    def index
      @schedules = Schedule.all
      stylists = Stylist.nearest_stylists(params[:lat], params[:long])
      @schedules = Schedule.joins(:stylist_schedules).where(stylist_schedules: { stylist_id: stylists })
      @schedules = @schedules.filter_by_service(params[:service_id]) if params[:service_id]
      @schedules = @schedules.from_date(params[:from_date]) if params[:from_date]
      @schedules = @schedules.to_date(params[:to_date]) if params[:to_date]
      json_response(@schedules)
    end

    # POST /schedules
    def create
      @schedule = Schedule.new(schedule_params)
      authorize @schedule
      CreateScheduleService.new(schedule_params, stylist_id).call
      json_response(@schedule, :created)
    end

    # GET /schedules/:id
    def show
      json_response(@schedule)
    end

    # PUT /schedules/:id
    def update
      authorize @schedule
      @schedule.update(schedule_params)
      head :no_content
    end

    # DELETE /schedules/:id
    def destroy
      authorize @schedule
      @schedule.destroy
      head :no_content
    end

    private

    def schedule_params
      params.require(:schedules).permit(:date, service_ids: [])
    end

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def stylist_id
      current_user.id
    end
  end
end
