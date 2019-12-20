class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.belongs_to :booking, foreign_key: true
      t.belongs_to :client, foreign_key: true
      t.belongs_to :stylist, foreign_key: true
      t.text :text
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
