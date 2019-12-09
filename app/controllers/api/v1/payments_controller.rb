module Api::V1
  class PaymentsController < BaseController
    before_action :set_payment, only: [:show, :update, :destroy]

    # GET payments
    def index
      @payments = []
      @payments = Payment.by_stylist(params[:stylist_id]) if params[:stylist_id]
      json_response(@payments)
    end

    # POST payments
    def create
      if customer_id && booking
        amount = booking.fee + (tip_fee || 0)
        # TODO: Handle discounts
        card_token = booking.card_token
        receipt_email = booking.client.user.email
        # TODO: Update description to include service names

        service_names = booking.services.map{|s| s['name']}.join(',').chomp(',')
        description = "Charges for #{service_names} with Blowout Go Out"
        stripe_charge = StripeCharge.call(
          customer_id,
          amount,
          card_token,
          description,
          receipt_email
        )

        if stripe_charge.result
          @payment = Payment.new
          authorize @payment
          @payment.booking = booking
          @payment.tip_fee = tip_fee
          @payment.amount = amount
          @payment.charge_id = stripe_charge.result.id
          @payment.save!
          booking.update(status: 'completed')

          json_response(@payment, :created)
        else
          msg = 'Some card or booking data are incorrect, please check and try again.'
          json_response(stripe_charge.errors, :unprocessable_entity)
        end
      else
        msg = 'Some card or booking data are incorrect, please check and try again.'
        json_response({ message: msg }, :unprocessable_entity)
      end
    end

    # GET payments/:id
    def show
      json_response(@payment)
    end

    # PUT payments/:id
    def update
      authorize @payment
      @payment.update(payment_params)
      head :no_content
    end

    # DELETE payments/:id
    def destroy
      authorize @payment
      @payment.destroy
      head :no_content
    end

    private

    def payment_params
      params.require(:payments).permit(:booking_id, :tip_fee)
    end

    def set_payment
      @payment = Payment.find(params[:id])
    end

    def tip_fee
      (params[:payments][:tip_fee] || 0).to_d
    end

    def booking
      return nil unless params[:payments]
      @booking ||= Booking.confirmed.find_by_id(params[:payments][:booking_id])
    end

    def customer_id
      @customer_id ||= booking&.client&.customer_id
    end
  end
end
