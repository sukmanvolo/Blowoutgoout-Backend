class DropAvailabilities < ActiveRecord::Migration[5.2]
  def change
    drop_table :availabilities
  end
end
