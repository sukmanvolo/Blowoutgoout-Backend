GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = Rails.env.development? ? 'http://localhost:3000' : 'https://bogo-staging.herokuapp.com'
end
GrapeSwaggerRails.options.app_name = 'Bogo'
GrapeSwaggerRails.options.url = '/bogo.yml'
GrapeSwaggerRails.options.doc_expansion = 'list'
GrapeSwaggerRails.options.hide_url_input = true
GrapeSwaggerRails.options.hide_api_key_input = true