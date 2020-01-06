module Api::V1
  class BookingsController < BaseController
    before_action :set_booking, only: [:show, :update, :destroy, :confirm,
                                       :reject, :complete]
    before_action :stylist_schedule, only: [:create]

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
      if stylist_available? && @booking.save
        @stylist_schedule.update(available: false)
        json_response(@booking, :created)
      else
        if stylist_available?
          json_response(@booking.errors.messages, :unprocessable_entity)
        else
          json_response({ "error": stylist_error_msg }, :unprocessable_entity)
        end
      end
    end

    # GET /bookings/:id
    def show
      json_response(@booking)
    end

    # PUT /bookings/:id
    def update
      authorize @booking
      if @booking.update(booking_params)
        json_response(@booking, :accepted)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    # DELETE /bookings/:id
    def destroy
      if @booking.update_attribute(:status, 'cancelled')
        CreateNotification.call(current_user, cancel_notification)
        json_response(@booking, :no_content)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    # PUT /bookings/:id/confirm
    def confirm
      authorize @booking
      if @booking.update_attribute(:status, 'confirmed')
        json_response(@booking, :accepted)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    def complete
      authorize @booking
      if @booking.update_attribute(:status, 'completed')
        json_response(@booking, :accepted)
      else
        json_response(@booking.errors.messages, :unprocessable_entity)
      end
    end

    # PUT /bookings/:id/reject
    def reject
      authorize @booking
      if @booking.update_attribute(:status, 'rejected')
        @stylist_schedule = @booking.stylist_schedule
        @stylist_schedule.update(available: true) if @stylist_schedule
        CreateNotification.call(current_user, cancel_notification)
        json_response(@booking, :accepted)
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
      params.require(:bookings).permit(:client_id, :stylist_id,
                                       :time_from, :time_to, :service_lat,
                                       :service_long, :date, :status, :schedule_id,
                                       :card_token, :service_amount, :notes, service_ids: [])
    end

    def stylist_available?
      return nil unless @stylist_schedule.present?
      @stylist_schedule.available?
    end

    def stylist_schedule
      data = params[:bookings]
      @stylist_schedule ||= StylistSchedule.where(stylist_id: data[:stylist_id],
                                                  schedule_id: data[:schedule_id],
                                                  start_time: data[:time_from]).first
    end

    def set_booking
      @booking = appointments.find_by_id(params[:id])
    end

    def cancel_notification
      "Your booking " \
      "on #{@booking.date} at #{@booking.time_from.strftime('%m-%d-%Y %H:%M')} " \
      "has been canceled"
    end

    def stylist_error_msg
      "The stylist is not longer available on " \
      "#{@booking&.date} at #{@booking&.time_from&.strftime('%m-%d-%Y %H:%M')}"
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
