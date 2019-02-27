class FilterNearestServices
  prepend SimpleCommand

  attr_accessor :lat, :long, :service_type_id

  def initialize(lat, long, service_type_id)
    @lat = lat
    @long = long
    @service_type_id = service_type_id
  end

  def call
    stylists = Stylist.actives.within(20, origin: [lat, long])
    Service.actives.where(service_type: service_type_id, stylist: stylists)
  end
end