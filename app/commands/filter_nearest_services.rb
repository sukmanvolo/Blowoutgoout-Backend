class FilterNearestServices
  prepend SimpleCommand

  attr_accessor :lat, :long, :service_type_id, :distance

  def initialize(lat, long, service_type_id, distance = 25)
    @lat = lat
    @long = long
    @service_type_id = service_type_id
    @distance = distance
  end

  def call
    stylists = Stylist.nearest_stylists(distance, lat, long)
    Service.actives.where(service_type: service_type_id).joins(:stylist_services).where( stylist_services: {stylist: stylists})
  end
end
