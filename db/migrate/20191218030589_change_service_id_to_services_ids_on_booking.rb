class ChangeServiceIdToServicesIdsOnBooking < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :service_id, :bigint
    add_column :bookings, :service_ids, :bigint, array: true, default: []
  end
end
