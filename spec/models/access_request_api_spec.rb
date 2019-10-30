require "rails_helper"

describe AccessRequestAPI, type: :model do
  describe "#approve" do
    let!(:approve_mock) { stub_api_v2_request "/access_requests/1/approve", nil, :post }

    it "posts to backend approve endpoint" do
      access_request = AccessRequestAPI.new(id: 1)
      access_request.approve
      assert_requested approve_mock
    end
  end

  describe "#create" do
    let!(:create_mock) { stub_api_v2_request "/access_requests", nil, :post }

    it "posts to backend create endpoint" do
      AccessRequestAPI.create
      assert_requested create_mock
    end
  end
end
