module Api::V1
  class BookingsController < BaseController
    before_action :set_booking, only: [:show, :update, :destroy, :confirm, :reject]

    # GET /bookings
    def index
      @bookings = Booking.all
      @bookings = Booking.by_client(params[:client_id]) if params[:client_id]
      @bookings = Booking.by_stylist(params[:stylist_id]) if params[:stylist_id]
      json_response(@bookings)
    end

    # POST /bookings
    def create
      @booking = Booking.new(booking_params)
      authorize @booking
      @booking.save!
      json_response(@booking, :created)
    end

    # GET /bookings/:id
    def show
      json_response(@booking)
    end

    # PUT /bookings/:id
    def update
      authorize @booking
      @booking.attributes = booking_params
      if UpdateBooking.call(@booking).result
        json_response(@booking, :accepted)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    # DELETE /bookings/:id
    def destroy
      authorize @booking
      @booking.destroy
      head :no_content
    end

    # PUT /bookings/:id/confirm
    def confirm
      authorize @booking
      @booking.status = 'confirmed'
      if ChangeBookingStatus.call(@booking).result
        availability.update(status: 'used')
        json_response(@booking, :accepted)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    # PUT /bookings/:id/reject
    def reject
      authorize @booking
      @booking.status = 'rejected'
      if ChangeBookingStatus.call(@booking).result
        availability.update(status: 'free')
        CreateNotification.call(current_user, cancel_notification)
        json_response(@booking, status: :accepted)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    # PUT /bookings/upcoming_appointments
    def upcoming_appointments
      @bookings = Booking.by_client(params[:client_id]) if params[:client_id]
      @bookings = Booking.by_stylist(params[:stylist_id]) if params[:stylist_id]
      @bookings = @bookings&.upcoming
      json_response(@bookings)
    end

    def past_appointments
      @bookings = Booking.by_client(params[:client_id]) if params[:client_id]
      @bookings = @bookings.past
      json_response(@bookings)
    end

    private

    def booking_params
      params.require(:bookings).permit(:client_id, :stylist_id, :service_id,
                                       :time_from, :time_to, :fee, :service_lat,
                                       :service_long, :date, :status, :availability_id)
    end

    def set_booking
      @booking = Booking.find_by_id(params[:id])
    end

    def cancel_notification
      "Your booking for the service #{@booking.service_name} " \
      "on #{@booking.date} at #{@booking.time_from.strftime('%m-%d-%Y %H:%M')} " \
      "has been canceled"
    end

    def availability
      Availability.find_by_id(@booking.availability_id)
    end
  end
end
