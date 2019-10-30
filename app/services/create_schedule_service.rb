class CreateScheduleService
  attr_accessor :schedule_data, :stylist_id

  def initialize(schedule_data, stylist_id)
    @schedule_data = schedule_data
    @stylist_id = stylist_id
  end

  def call
    begin
      schedules = Schedule.joins(:stylist_schedules)
                          .where(stylist_schedules: { stylist_id: stylist_id })
                          .where(schedules: { date: schedule_data[:date] })

      # filter by service_ids array
      schedules = schedules.reject{ |s| s.service_ids != schedule_data[:service_ids] }

      schedule = schedules.first
      if schedule.nil?
        schedule = Schedule.new(service_ids: services, date: schedule_date)
        schedule.save!
      end
      associate_to_stylist(schedule)
      return schedule
    rescue => e
      puts "*** CreateScheduleService error: #{e}"
      return schedule
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
    sc = StylistSchedule.new(stylist_id: stylist_id, schedule_id: schedule.id, start_time: schedule_data[:start_time])
    if sc.valid?
      sc.save
    else
      sc.errors.messages.each do |k,v|
        schedule.errors.add(:base, "Schedule creation error => #{k}: #{v.join(';')}")
      end
    end
  end
end