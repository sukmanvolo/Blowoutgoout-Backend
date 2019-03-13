class PagesController < ApplicationController
  before_action :authorize, except: %i[home about_us contact_us]
  skip_before_action :require_login

  def home; end

  def stylists; end

  def faq; end

  def privacy; end

  def terms; end

  def about_us; end

  def contact_us; end
end
