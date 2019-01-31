class CreateUserServices < ActiveRecord::Migration[5.2]
  def change
    create_table :user_services do |t|
      t.datetime :date, null: false
      t.string :comments
      t.references :user
      t.references :service
      t.timestamps
    end
  end
end
