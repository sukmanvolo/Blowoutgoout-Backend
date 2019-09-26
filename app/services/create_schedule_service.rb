class CreateScheduleService
  attr_accessor :schedule_data, :stylist_id

  def initialize(schedule_data, stylist_id)
    @schedule_data = schedule_data
    @stylist_id = stylist_id
  end

  def call
    begin
      services.each do |id|
        schedule = Schedule.filter_by_service(id).where(date: schedule_date)&.first
        if schedule.nil?
          schedule = Schedule.create(service_ids: [id], date: schedule_date)
        end
        associate_to_stylist(schedule)
      end
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