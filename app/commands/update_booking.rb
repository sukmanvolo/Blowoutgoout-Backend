class UpdateBooking
  prepend SimpleCommand

  attr_accessor :booking

  def initialize(booking)
    @booking = booking
  end

  def call
    return false if !booking.valid?

    if booking.changed?
      if booking.status_changed? && booking.status_was == "confirmed"
        booking.errors.add(:status, "You can not edit this appointment")
      else
        # TODO: send push notification.
        booking.status = 'pending'
      end
      booking.errors.empty? && booking.save
    end
  end
end
