if Rails.env.development? || Rails.env.test?
  AUTHENTICATION = { 'super.admin@education.gov.uk' => 'beta' }.freeze # email matches seeds.rb
elsif ENV['AUTHENTICATION_CREDENTIALS'].blank?
  raise "In non-development mode, AUTHENTICATION_CREDENTIALS needs to be set with JSON key-value pairs with email and password"
else
  AUTHENTICATION = JSON.parse(ENV['AUTHENTICATION_CREDENTIALS'])
end
