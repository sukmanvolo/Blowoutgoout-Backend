class FacebookService

  def self.valid_token?(access_token)
    status = false
    begin
      debug_token = Koala::Facebook::API.new(access_token).debug_token(app_access_token_info['access_token'])
      status = true if debug_token['data']['is_valid']
    ensure
      return status
    end
  end

  def self.fetch_data(access_token)
    Koala::Facebook::API.new(access_token).get_object('me', fields: 'name,first_name,last_name,email,picture.width(500)') if valid_token?(access_token)
  end

  def self.app_access_token_info
    @app_access_token ||= Koala::Facebook::OAuth.new.get_app_access_token_info
  end

end