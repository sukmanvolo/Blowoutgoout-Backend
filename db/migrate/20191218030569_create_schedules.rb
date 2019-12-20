class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.belongs_to :stylist, foreign_key: true
      t.belongs_to :service_type, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
