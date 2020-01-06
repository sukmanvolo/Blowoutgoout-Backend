class DropFeeFromBooking < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :fee, :decimal
  end
end
