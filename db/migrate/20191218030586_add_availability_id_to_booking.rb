class AddAvailabilityIdToBooking < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookings, :availability, index: true
  end
end
