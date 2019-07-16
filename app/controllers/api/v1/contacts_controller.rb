module Api::V1
  class ContactsController < BaseController

    # POST /cards
    def create
      if UserMailer.send_message(current_user, message, subject).deliver_now
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

    def subject
      params[:contacts] && params[:contacts][:subject]
    end

    def notification_message
      "Your message #{subject} was sent at #{Time.now.strftime('%m-%d-%Y %H:%M')}"
    end
  end
end
