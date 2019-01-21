class PagesController < ApplicationController
  before_action :authorize, except: %i[home about_us contact_us]

  def home; end

  def about_us; end

  def contact_us; end
end
