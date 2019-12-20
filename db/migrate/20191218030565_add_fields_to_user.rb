class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer
    add_column :users, :gcm_id, :string
    add_column :users, :device_type, :string
    add_column :users, :device_id, :string
    add_column :users, :status, :integer, default: 1
  end
end
