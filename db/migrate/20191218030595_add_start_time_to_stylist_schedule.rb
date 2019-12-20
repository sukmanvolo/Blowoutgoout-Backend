class AddStartTimeToStylistSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :stylist_schedules, :start_time, :time
    remove_index :stylist_schedules, name: "index_stylist_schedules_on_stylist_id_and_schedule_id"
    add_index :stylist_schedules, [:stylist_id, :schedule_id, :start_time], name: "index_stylist_id_and_schedule_id_and_start_time", unique: true
  end
end
