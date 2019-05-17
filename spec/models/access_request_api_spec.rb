require 'rails_helper'

describe AccessRequestAPI, type: :model do
  let(:token) { "one-ring-to-rule-them-all" }

  before do
    allow(Thread.current).to receive(:fetch)
                                 .with(:manage_courses_backend_token)
                                 .and_return(token)
  end

  describe "#approve" do
    let!(:approve_mock) { stub_api_v2_request "/access_requests/1/approve", nil, :post, token: token }

    it "posts to backend approve endpoint" do
      access_request = AccessRequestAPI.new(id: 1)
      access_request.approve
      assert_requested approve_mock
    end
  end

  describe "#create" do
    let!(:create_mock) { stub_api_v2_request "/access_requests", nil, :post, token: token }

    it "posts to backend create endpoint" do
      AccessRequestAPI.create
      assert_requested create_mock
    end
  end
end
