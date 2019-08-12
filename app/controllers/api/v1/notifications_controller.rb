module Api::V1
  class NotificationsController < BaseController

    # GET /notifications
    def index
      @notifications = filters_exists? ? Notification.all : []
      @notifications = @notifications.by_user(user_id) if filters_exists?
      json_response(@notifications)
    end

    private

    def filters_exists?
      params[:client_id] || params[:stylist_id]
    end

    def user_id
      user_id = Client.find_by_id(params[:client_id])&.id if params[:client_id].present?
      user_id = Stylist.find_by_id(params[:stylist_id])&.id if params[:stylist_id].present?
      user_id
    end
  end
end
