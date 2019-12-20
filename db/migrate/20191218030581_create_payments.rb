class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.belongs_to :booking, foreign_key: true
      t.string :coupon_code
      t.integer :discount_percent
      t.decimal :tip_fee
      t.decimal :discount
      t.decimal :amount
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
