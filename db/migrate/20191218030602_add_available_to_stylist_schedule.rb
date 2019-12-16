class AddAvailableToStylistSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :stylist_schedules, :available, :boolean, default: true
  end
end
