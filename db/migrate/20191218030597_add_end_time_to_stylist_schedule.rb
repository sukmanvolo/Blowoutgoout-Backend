class AddEndTimeToStylistSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :stylist_schedules, :end_time, :time
  end
end
