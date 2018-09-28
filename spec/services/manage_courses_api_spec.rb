require 'rails_helper'

API_URL = "https://www.example.com".freeze
HEADERS = {
  'Accept' => 'application/json',
  'Authorization' => "Bearer 12345",
}.freeze

RSpec.describe "Manage Courses API Service", type: :request do
  describe "approving access requests" do
    it "handles 200 correctly" do
      stub_request(:post, "#{API_URL}/api/admin/access-request?accessRequestId=1")
        .with(headers: HEADERS)
        .to_return(status: 200)

      result = MANAGE_COURSES_API.approve_access_request(1)

      expect(result).to eq('success')
    end

    it "handles 401 correctly" do
      stub_request(:post, "#{API_URL}/api/admin/access-request?accessRequestId=1")
        .with(headers: HEADERS)
        .to_return(status: 401)

      result = MANAGE_COURSES_API.approve_access_request(1)

      expect(result).to eq('unauthorized')
    end

    it "handles 404 correctly" do
      stub_request(:post, "#{API_URL}/api/admin/access-request?accessRequestId=1")
        .with(headers: HEADERS)
        .to_return(status: 404)

      result = MANAGE_COURSES_API.approve_access_request(1)

      expect(result).to eq('not-found')
    end

    it "handles unknown status code correctly" do
      stub_request(:post, "#{API_URL}/api/admin/access-request?accessRequestId=1")
        .with(headers: HEADERS)
        .to_return(status: 999)

      result = MANAGE_COURSES_API.approve_access_request(1)

      expect(result).to eq('unknown-error')
    end
  end

  describe "manually approving access requests" do
    it "correctly forms query string parameters" do
      stub_request(:post, "#{API_URL}/api/admin/manual-access-request")
        .with(query: {
          requesterEmail: 'foo@bar.com',
          targetEmail: 'baz@qux.com',
          firstName: 'baz',
          lastName: 'qux'
        })
        .with(headers: HEADERS)
        .to_return(status: 200)

      result = MANAGE_COURSES_API.manually_approve_access_request(
        requester_email: 'foo@bar.com',
        target_email: 'baz@qux.com',
        first_name: 'baz',
        last_name: 'qux'
      )

      expect(result).to eq('success')
    end
  end
end
