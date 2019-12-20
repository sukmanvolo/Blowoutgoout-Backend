class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.belongs_to :schedule, foreign_key: true
      t.time :time_from
      t.time :time_to

      t.timestamps
    end
  end
end
