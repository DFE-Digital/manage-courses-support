require 'rails_helper'

API_URL = "https://www.example.com".freeze
HEADERS = {
  'Accept' => 'application/json',
  'Authorization' => "Bearer 12345",
}.freeze

RSpec.describe "Manage Courses API Service", type: :request do
  describe "approving access requests" do
    it "handles 200 correctly" do
      request = stub_request(:post, "#{API_URL}/api/admin/access-request?accessRequestId=1")
        .with(headers: HEADERS)
        .to_return(status: 200)

      MANAGE_COURSES_API.approve_access_request(id: 1)

      expect(request).to have_been_made
    end

    it "handles 401 correctly" do
      stub_request(:post, "#{API_URL}/api/admin/access-request?accessRequestId=1")
        .with(headers: HEADERS)
        .to_return(status: 401)

      expect {
        MANAGE_COURSES_API.approve_access_request(id: 1)
      }.to raise_error ManageCoursesAPI::AccessRequestInternalFailure, /unauthorized/
    end

    it "handles 404 correctly" do
      stub_request(:post, "#{API_URL}/api/admin/access-request?accessRequestId=1")
        .with(headers: HEADERS)
        .to_return(status: 404)

      expect {
        MANAGE_COURSES_API.approve_access_request(id: 1)
      }.to raise_error ManageCoursesAPI::AccessRequestInternalFailure, /not found/
    end

    it "handles network failure correctly" do
      stub_request(:post, "#{API_URL}/api/admin/access-request?accessRequestId=1")
        .with(headers: HEADERS)
        .to_raise(Errno::ECONNREFUSED)

      expect {
        MANAGE_COURSES_API.approve_access_request(id: 1)
      }.to raise_error ManageCoursesAPI::AccessRequestInternalFailure, /Connection refused/
    end

    it "handles unknown status code correctly" do
      stub_request(:post, "#{API_URL}/api/admin/access-request?accessRequestId=1")
        .with(headers: HEADERS)
        .to_return(status: 999)

      expect {
        MANAGE_COURSES_API.approve_access_request(id: 1)
      }.to raise_error ManageCoursesAPI::AccessRequestInternalFailure, /unexpected response code 999/
    end
  end

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
