class AddStripeIdToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :stripe_id, :string
  end
end
