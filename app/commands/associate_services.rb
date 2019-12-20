class AssociateServices
  prepend SimpleCommand

  attr_accessor :stylist

  def initialize(stylist)
    @stylist = stylist
  end

  def call
    Service.actives.each do |s|
      StylistService.create(stylist: stylist, service: s)
    end
  end
end