class CreateServiceTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :service_types do |t|
      t.string :name
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
