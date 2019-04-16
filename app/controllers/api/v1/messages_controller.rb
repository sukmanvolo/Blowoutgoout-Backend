module Api::V1
  class MessagesController < BaseController
    before_action :set_message, only: [:show, :update, :destroy]
    before_action :set_booking, only: [:index]

    # GET /messages
    def index
      @messages = Message.all
      @messages = @messages.by_booking(@booking) if @booking
      json_response(@messages)
    end

    # POST /messages
    def create
      @message = Message.new(message_params)
      authorize @message
      @message.save!
      json_response(@message, :created)
    end

    # GET /messages/:id
    def show
      json_response(@message)
    end

    # PUT /messages/:id
    def update
      authorize @message
      @message.update(message_params)
      head :no_content
    end

    # DELETE /messages/:id
    def destroy
      authorize @message
      @message.destroy
      head :no_content
    end

    private

    def message_params
      params.require(:messages).permit(:booking_id, :client_id, :stylist_id, :text)
    end

    def set_message
      @message ||= Message.find_by_id(params[:id])
    end

    def set_booking
      id = params[:messages] && params[:messages][:booking_id]
      @booking ||= Booking.find_by_id(id)
    end
  end
end
