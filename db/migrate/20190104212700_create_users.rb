class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, blank: false
      t.string :password_digest, blank: false
      t.timestamps
    end
  end
end
