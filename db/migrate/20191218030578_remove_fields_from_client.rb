class RemoveFieldsFromClient < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :first_name, :string
    remove_column :clients, :last_name, :string
    remove_column :clients, :phone, :string
  end
end
