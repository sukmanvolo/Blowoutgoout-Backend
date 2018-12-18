class PagesController < ApplicationController
  skip_before_action :require_login, only: %i[home about_us contact_us]

  def home; end

  def about_us; end

  def contact_us; end
end
