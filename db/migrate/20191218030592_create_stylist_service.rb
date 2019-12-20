class CreateStylistService < ActiveRecord::Migration[5.2]
  def change
    create_table :stylist_services do |t|
      t.belongs_to :stylist, foreign_key: true
      t.belongs_to :service, foreign_key: true
    end
  end
end
