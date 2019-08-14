module Api::V1
  class ContactsController < BaseController

    # POST /contacts
    def create
      if UserMailer.send_message(current_user, message).deliver_now
        CreateNotification.call(current_user, notification_message)
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: ['Email not was sent. Please check and try again.'] }, status: :unprocessable_entity
      end
    end

  private

    def message
      params[:contacts] && params[:contacts][:message]
    end

    def notification_message
      "Your message to contact support was sent at #{Time.now.strftime('%m-%d-%Y %H:%M')}"
    end
  end
end
