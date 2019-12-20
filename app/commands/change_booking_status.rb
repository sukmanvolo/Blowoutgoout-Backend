class ChangeBookingStatus
  prepend SimpleCommand

  attr_accessor :booking

  def initialize(booking)
    @booking = booking
  end

  def call
    return false if !booking.valid?

    if booking.status_changed?
      if booking.status == 'confirmed' && booking.status_was != 'pending'
        booking.errors.add(:status, 'You can not change to confirmed this booking')
      end

      if booking.status == 'rejected' && booking.status_was != 'pending'
        booking.errors.add(:status, 'You can not change to rejected this booking')
      end

      if booking.status == 'completed' && booking.status_was != 'confirmed'
        booking.errors.add(:status, 'You can not change to completed this booking')
      end

      booking.errors.empty? && booking.save
    end
  end
end
