module Api::V1
  class BookingsController < BaseController
    before_action :set_booking, only: [:show, :update, :destroy, :confirm, :reject]

    # GET /bookings
    def index
      @bookings = Bookings.all
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
        json_response(@booking, status: :accepted)
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
        json_response(@booking, status: :accepted)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    # PUT /bookings/:id/reject
    def reject
      authorize @booking
      @booking.status = 'rejected'
      if ChangeBookingStatus.call(@booking).result
        json_response(@booking, status: :accepted)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    private

    def booking_params
      params.require(:bookings).permit(:client_id, :stylist_id, :service_id, :time_from,
                                      :time_to, :fee, :service_lat, :service_long, :status)
    end

    def set_booking
      @booking = Booking.find(params[:id])
    end
  end
end
