require 'rails_helper'

API_URL = "https://www.example.com/api/admin/access-request?accessRequestId=1".freeze
HEADERS = {
  'Accept' => 'application/json',
  'Authorization' => "Bearer 12345",
}.freeze

RSpec.describe "Manage Courses API Service", type: :request do
  describe "approving access requests" do
    it "handles 200 correctly" do
      stub_request(:post, API_URL)
        .with(headers: HEADERS)
        .to_return(status: 200)

      result = MANAGE_COURSES_API_SERVICE.approve_access_request(1)

      expect(result).to eq('success')
    end

    it "handles 401 correctly" do
      stub_request(:post, API_URL)
        .with(headers: HEADERS)
        .to_return(status: 401)

      result = MANAGE_COURSES_API_SERVICE.approve_access_request(1)

      expect(result).to eq('unauthorized')
    end

    it "handles 404 correctly" do
      stub_request(:post, API_URL)
        .with(headers: HEADERS)
        .to_return(status: 404)

      result = MANAGE_COURSES_API_SERVICE.approve_access_request(1)

      expect(result).to eq('not-found')
    end

    it "handles unknown status code correctly" do
      stub_request(:post, API_URL)
        .with(headers: HEADERS)
        .to_return(status: 999)

      result = MANAGE_COURSES_API_SERVICE.approve_access_request(1)

      expect(result).to eq('unknown-error')
    end
  end
end
