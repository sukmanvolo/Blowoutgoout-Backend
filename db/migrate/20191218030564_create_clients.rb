class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :facebook_id
      t.integer :user_id
    end

    add_index :clients, :user_id
  end
end
