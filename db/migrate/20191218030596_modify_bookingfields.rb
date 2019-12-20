class ModifyBookingfields < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :availability_id, :bigint
    add_reference :bookings, :schedule, foreign_key: true
  end
end
