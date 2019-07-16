class ChangeServiceModel < ActiveRecord::Migration[5.2]
  def change
    add_reference :services, :service_type, foreign_key: true
    add_reference :services, :stylist, foreign_key: true
    add_column :services, :amount, :decimal, precision: 10, scale: 2
    add_column :services, :status, :integer, default: 1
    remove_column :services, :service_type, :integer
    remove_column :services, :active, :boolean

  end
end
