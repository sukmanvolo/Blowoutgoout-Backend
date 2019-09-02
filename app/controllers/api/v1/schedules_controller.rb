module Api::V1
  class SchedulesController < BaseController
    before_action :set_schedule, only: [:show, :update, :destroy]
    before_action :set_data_params, only: [:index]

    # GET /schedules
    def index
      @schedules = Schedule.all
      @schedules = @schedules.filter_by_stylist(@stylist) if params[:stylist_id]
      @schedules = @schedules.filter_by_service(@service) if params[:service_id]
      @schedules = @schedules.from_date(@from_date) if params[:from_date]
      @schedules = @schedules.to_date(@to_date) if params[:to_date]
      json_response(@schedules)
    end

    # POST /schedules
    def create
      @schedule = Schedule.new(schedule_params)
      authorize @schedule
      @schedule.save!
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
      params.require(:schedules).permit(:stylist_id, :service_ids, :date)
    end

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def set_data_params
      @stylist = params[:stylist_id]
      @service = params[:service_id]
      @from_date = params[:from_date]
      @to_date = params[:to_date]
    end
  end
end
