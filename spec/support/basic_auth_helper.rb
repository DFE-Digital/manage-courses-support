module BasicAuthHelper
  def login
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("super.admin@education.gov.uk","beta")
  end
end

RSpec.configure do |config|
  config.include BasicAuthHelper, type: :controller
end
