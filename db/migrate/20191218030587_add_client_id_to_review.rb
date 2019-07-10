class AddClientIdToReview < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :client, foreign_key: true
  end
end
