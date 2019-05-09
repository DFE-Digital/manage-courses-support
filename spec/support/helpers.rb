module Helpers
  def stub_api_v2_request(url_path, stub, method = :get, status = 200, token: nil)
    url = "#{Settings.manage_backend.base_url}/api/v2#{url_path}"

    stubbed_request = stub_request(method, url)
                        .to_return(
                          status: status,
                          body: stub.to_json,
                          headers: { 'Content-Type': 'application/vnd.api+json' }
                        )
    if token
      stubbed_request.with(
        headers: {
          'Accept'          => 'application/vnd.api+json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'   => "Bearer #{token}",
          'Content-Type'    => 'application/vnd.api+json',
          'User-Agent'      => 'Faraday v0.15.4'
        }
      )
    end

    stubbed_request
  end
end

RSpec.configure do |config|
  config.include Helpers, type: :feature
end
