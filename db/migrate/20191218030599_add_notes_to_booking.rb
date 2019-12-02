class AddNotesToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :notes, :string
  end
end
