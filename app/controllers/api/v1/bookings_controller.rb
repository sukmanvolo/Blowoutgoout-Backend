module Api::V1
  class BookingsController < BaseController
    before_action :set_booking, only: [:show, :update, :destroy, :confirm,
                                       :reject, :complete]

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
      @booking.status = 'cancelled'
      if ChangeBookingStatus.call(@booking).result
        CreateNotification.call(current_user, cancel_notification)
        json_response(@booking, :no_content)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    # PUT /bookings/:id/confirm
    def confirm
      authorize @booking
      @booking.status = 'confirmed'
      if ChangeBookingStatus.call(@booking).result
        json_response(@booking, :accepted)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    def complete
      authorize @booking
      @booking.status = 'completed'
      if ChangeBookingStatus.call(@booking).result
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
        CreateNotification.call(current_user, cancel_notification)
        json_response(@booking, status: :accepted)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    # PUT /bookings/upcoming_appointments
    def upcoming_appointments
      @bookings = appointments&.upcoming || []
      json_response(@bookings)
    end

    def past_appointments
      @bookings = appointments&.past || []
      json_response(@bookings)
    end

    private

    def booking_params
      params.require(:bookings).permit(:client_id, :stylist_id, :service_ids,
                                       :time_from, :time_to, :fee, :service_lat,
                                       :service_long, :date, :status, :schedule_id,
                                       :card_token, :service_amount)
    end

    def set_booking
      @booking = appointments.find_by_id(params[:id])
    end

    def cancel_notification
      "Your booking " \
      "on #{@booking.date} at #{@booking.time_from.strftime('%m-%d-%Y %H:%M')} " \
      "has been canceled"
    end

    def appointments
      if current_user.client?
        Booking.by_client(current_user&.client&.id)
      elsif current_user.stylist?
        Booking.by_stylist(current_user&.stylist&.id)
      end
    end
  end
end
