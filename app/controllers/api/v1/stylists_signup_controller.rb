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
      params.require(:stylists).permit(:years_of_experience, :license_agreement,
                                       :has_smartphone, :has_transportation,
                                       :portfolio_link, :is_eligible_to_work_in_us,
                                       :previous_contractor_date, :has_conviction,
                                       :agrees_to_unemployment_understanding,
                                       :agrees_to_taxation_understanding,
                                       :image, user_attributes: [:id, :first_name, :last_name,
                                       :phone,:email, :password, :role, :gcm_id, :device_type,
                                       :device_id, :status])
    end
  end
end