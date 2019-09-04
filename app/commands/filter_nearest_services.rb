class FilterNearestServices
  prepend SimpleCommand

  attr_accessor :lat, :long, :service_type_id

  def initialize(lat, long, service_type_id)
    @lat = lat
    @long = long
    @service_type_id = service_type_id
  end

  def call
    stylists = Stylist.nearest_stylists(lat, long)
    Service.actives.where(service_type: service_type_id).joins(:stylist_services).where( stylist_services: {stylist: stylists})
  end
end