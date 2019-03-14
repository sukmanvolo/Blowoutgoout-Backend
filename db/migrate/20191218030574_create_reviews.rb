class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :text
      t.float :rate, default: 0.0
      t.belongs_to :stylist, foreign_key: true
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
