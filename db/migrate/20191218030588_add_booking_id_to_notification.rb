class AddBookingIdToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :booking_id, :bigint
  end
end
