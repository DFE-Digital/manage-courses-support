if Rails.env.development? or Rails.env.test?
  AUTHENTICATION = { 'bat' => 'beta' }
elsif Rails.env.production? and ENV['AUTHENTICATION_CREDENTIALS'].present?
  AUTHENTICATION = JSON.parse(ENV['AUTHENTICATION_CREDENTIALS'])
else
  raise "In production mode, AUTHENTICATION_CREDENTIALS needs to be set with JSON key-value pairs with email and password"
end
