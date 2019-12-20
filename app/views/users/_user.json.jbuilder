json.extract! user, :id, :email
json.token token
json.url user_url(user, format: :json)
