require 'rails_helper'

describe AccessRequestAPI, type: :model do
  describe "#approve" do
    let!(:approve_mock) { stub_api_v2_request "/access_requests/1/approve", nil, :post, token: "one-ring-to-rule-them-all" }

    before do
      allow(Thread.current).to receive(:fetch)
                                 .with(:manage_courses_backend_token)
                                 .and_return("one-ring-to-rule-them-all")
    end

    it "posts to backend approve endpoint" do
      access_request = AccessRequestAPI.new(id: 1)
      access_request.approve
      assert_requested approve_mock
    end
  end
end
