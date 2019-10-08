class CreateScheduleService
  attr_accessor :schedule_data, :stylist_id

  def initialize(schedule_data, stylist_id)
    @schedule_data = schedule_data
    @stylist_id = stylist_id
  end

  def call
    begin
      services_count = params[:service_ids].count
      schedules = Schedule.joins(:stylist_schedules).where(stylist_schedules: { stylist_id: stylist_id })
      params[:service_ids].each do |service_id|
        schedules = schedules.filter_by_service(service_id).where(date: schedule_date)
      end

      # check services count
      schedules = schedules.reject{ |s| s.service_ids.count != services_count }

      schedule = schedules.first
      if schedule.nil?
        schedule = Schedule.create(service_ids: services, date: schedule_date)
      end
      associate_to_stylist(schedule)
    rescue => e
      puts "*** CreateScheduleService error: #{e}"
      false
    end
  end

  private

  def services
    schedule_data[:service_ids]
  end

  def schedule_date
    schedule_data[:date]
  end

  def associate_to_stylist(schedule)
    StylistSchedule.create(stylist_id: stylist_id, schedule_id: schedule.id)
  end
end