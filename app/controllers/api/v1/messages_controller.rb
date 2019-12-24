module Api::V1
  class MessagesController < BaseController
    before_action :set_message, only: [:show, :update, :destroy]

    # GET /messages
    def index
      return [] unless filters_exists?

      @messages = Message.by_booking(params[:booking_id]) if params[:booking_id]
      @messages = Message.conversation(params[:client_id], params[:stylist_id]) if params[:client_id] && params[:stylist_id]
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
      params.require(:messages).permit(:booking_id, :client_id, :stylist_id, :text, :sender)
    end

    def set_message
      @message ||= Message.find_by_id(params[:id])
    end

    def filters_exists?
      params[:booking_id] || params[:client_id] || params[:stylist_id]
    end
  end
end
