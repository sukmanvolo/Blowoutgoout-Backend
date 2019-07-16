class ChangeServiceTypeToService < ActiveRecord::Migration[5.2]
  def change
    rename_column :schedules, :service_type_id, :service_id
  end
end
