class AddBookingIdToReviews < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reviews, :stylist
    add_reference :reviews, :booking, foreign_key: true
  end
end
