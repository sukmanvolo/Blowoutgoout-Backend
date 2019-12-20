class ChangeServiceFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :services, :stylist_id, :bigint
    add_column :services, :duration, :int
  end
end
