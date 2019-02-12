module Api::V1
  class StylistsSignupController < ActionController::API
    include ::Api::Response
    include ::Api::ExceptionHandler

    def create
      @stylist = Stylist.create!(stylist_params)
      json_response(@stylist, :created)
    end

    private

    def stylist_params
      params.require(:stylists).permit(:first_name, :last_name, :phone,
                                      :user_id, :lat, :long, user_attributes: [
                                      :id, :email, :password, :role, :gcm_id,
                                      :device_type, :device_id, :status])
    end
  end
end