require 'rails_helper'

API_URL = "https://www.example.com".freeze
HEADERS = {
  'Accept' => 'application/json',
  'Authorization' => "Bearer 12345",
}.freeze

RSpec.describe "Manage Courses API Service", type: :request do
  describe "manually approving access requests" do
    it "correctly forms query string parameters" do
      request = stub_request(:post, "#{API_URL}/api/admin/manual-access-request")
        .with(query: {
          requesterEmail: 'foo@bar.com',
          targetEmail: 'baz@qux.com',
          firstName: 'baz',
          lastName: 'qux'
        })
        .with(headers: HEADERS)
        .to_return(status: 200)

      MANAGE_COURSES_API.manually_approve_access_request(
        requester_email: 'foo@bar.com',
        target_email: 'baz@qux.com',
        first_name: 'baz',
        last_name: 'qux'
      )

      expect(request).to have_been_made
    end
  end
end
