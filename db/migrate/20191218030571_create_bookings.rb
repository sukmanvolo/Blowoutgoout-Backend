class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.belongs_to :client, foreign_key: true
      t.belongs_to :stylist, foreign_key: true
      t.belongs_to :service, foreign_key: true
      t.time :time_from
      t.time :time_to
      t.decimal :fee, default: 0
      t.decimal :service_lat
      t.decimal :service_long
      t.integer :status

      t.timestamps
    end
  end
end
