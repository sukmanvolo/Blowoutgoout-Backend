module Api::V1
  class ContactsController < BaseController

    # POST /cards
    def create
      if UserMailer.send_message(current_user, message).deliver_now
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: ['Email not was sent. Please check and try again.'] }, status: :unprocessable_entity
      end
    end

  private

    def message
      params[:contacts] && params[:contacts][:message]
    end
  end
end
