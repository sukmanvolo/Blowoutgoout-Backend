services = Service.all
services.each do |service|
  next if service.name == 'Hair and Makeup'
  service_type = service.service_type_id == 1 ? 'Hair+Services' : 'Makeup+Services'
  service.image.attach(io: StringIO.new("https://blowout-go-out.s3.us-east-2.amazonaws.com/assets/services/#{service_type}/#{service.name.gsub(' ', '+')}.jpeg"), filename: "#{service.name}.jpeg", content_type: 'application/jpg')
end
