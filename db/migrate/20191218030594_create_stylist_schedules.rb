class CreateStylistSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :stylist_schedules do |t|
      t.belongs_to :stylist, foreign_key: true
      t.belongs_to :schedule, foreign_key: true

      t.timestamps
    end
    add_index :stylist_schedules, [:stylist_id, :schedule_id], unique: true
  end
end
