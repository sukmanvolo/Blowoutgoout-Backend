class AddStylistToServiceTypes < ActiveRecord::Migration[5.2]
  def change
    remove_column  :stylists, :service_type
    add_reference :service_types, :stylist, foreign_key: true
  end
end
