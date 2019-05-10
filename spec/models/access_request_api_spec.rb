require 'rails_helper'

describe AccessRequestAPI, type: :model do
  it "posts to backend approve endpoint" do
    approve_mock = stub_api_v2_request "/access_requests/1/approve", nil, :post
    Thread.current[:manage_courses_backend_token] = "one-ring-to-rule-them-all"
    access_request = AccessRequestAPI.new(id: 1)
    access_request.approve
    assert_requested approve_mock
  end
end
