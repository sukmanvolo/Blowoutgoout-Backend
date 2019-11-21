# frozen_string_literal: true

services = Service.all
stylists = Stylist.all

services.each do |service|
  stylists.each do |stylist|
    StylistService.find_or_create_by(
      stylist_id: stylist.id,
      service_id: service.id
    )
  end
end
