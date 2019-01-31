class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.integer :service_type, default: 0, null: false
      t.string :name, null: false
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
