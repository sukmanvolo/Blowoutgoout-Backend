class PagesController < ApplicationController
  skip_before_action :require_login

  def home; end

  def stylists; end

  def faq; end

  def privacy; end

  def about_us; end

  def contact_us; end
end
