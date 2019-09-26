class RemoveStylistIdFromSchedule < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :stylist_id, :bigint
  end

end
