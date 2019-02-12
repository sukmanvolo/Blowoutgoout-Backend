class CreateStylists < ActiveRecord::Migration[5.2]
  def change
    create_table :stylists do |t|
      t.string :first_name
      t.string :last_name
      t.text :description
      t.string :phone
      t.integer :welcome_kit, default: 0
      t.integer :service_type, default: 1
      t.integer :register_by
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :long, precision: 10, scale: 6
      t.integer :radius
      t.integer :user_id
      t.timestamps
    end

    add_index :stylists, :user_id
  end
end
