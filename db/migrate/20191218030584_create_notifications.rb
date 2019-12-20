class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.text :message
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
