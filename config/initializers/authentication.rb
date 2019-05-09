if Rails.env.development? || Rails.env.test?
  AUTHENTICATION = { 'super.admin@education.gov.uk' => 'beta' }.freeze # email matches seeds.rb
elsif Rails.env.production? && ENV['AUTHENTICATION_CREDENTIALS'].present?
  AUTHENTICATION = JSON.parse(ENV['AUTHENTICATION_CREDENTIALS'])
else
  raise "In production mode, AUTHENTICATION_CREDENTIALS needs to be set with JSON key-value pairs with email and password"
end
