class ChangeServiceIdToServicesIdsOnSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :service_id, :bigint
    add_column :schedules, :service_ids, :bigint, array: true, default: []
  end
end
