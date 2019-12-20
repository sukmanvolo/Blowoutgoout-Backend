class RemoveFieldsFromStylist < ActiveRecord::Migration[5.2]
  def change
    remove_column :stylists, :first_name, :string
    remove_column :stylists, :last_name, :string
    remove_column :stylists, :phone, :string
  end
end
