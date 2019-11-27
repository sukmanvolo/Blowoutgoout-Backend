class ModifyBookingTable < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :card_token, :string
    add_column :bookings, :service_amount, :decimal, precision: 10, scale: 2
  end
end
