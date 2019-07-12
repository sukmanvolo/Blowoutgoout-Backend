# frozen_string_literal: true

class SignupController < ApplicationController
  include Wicked::Wizard

  steps :profile, :forms, :complete

  def show
    @user = current_user || User.find(params[:stylist_id])
    case step
    when :forms
      @stylist = Stylist.new
    end
    render_wizard
  end

  def update
    case step
    when :profile
      @user = current_user || User.find(params[:stylist_id])
      @user.update_attributes!(params[:user].permit(:phone, :address, :city, :state, :postal_code))
      render_wizard @user
    when :forms
      @stylist = Stylist.find_or_create_by(params[:stylist].permit(
                                             :years_of_experience, :license_agreement,
                                             :has_smartphone, :has_transportation,
                                             :portfolio_link, :is_eligible_to_work_in_us,
                                             :previous_contractor_date, :has_conviction,
                                             :agrees_to_unemployment_understanding,
                                             :agrees_to_taxation_understanding

                                           ))
    end
  end
end


# TODO: fix file uploads:
# ,
# :image, :cosmetology_license, :liability_insurance,
# :eligibility_document
