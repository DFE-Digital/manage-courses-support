require "rails_helper"

BASE_API_URL = "https://www.example.com/api/access-request?accessRequestId=".freeze

RSpec.describe "Access requests index", type: :feature do
  include_context 'when authenticated'

  unapproved_request = FactoryBot.create(:access_request, :unapproved,
    first_name: "Jane",
    last_name: "Smith")

  FactoryBot.create(:access_request, :approved,
    first_name: "Leslie",
    last_name: "Jones")

  it "contains only unapproved requests" do
    visit "/access-requests"

    expect(page).to have_text("Jane")
    expect(page).to have_text("Smith")
    expect(page).not_to have_text("Leslie")
    expect(page).not_to have_text("Jones")
  end

  describe "displays notifications when approving access requests" do
    it "for a successful request" do
      stub_request(:post, "#{BASE_API_URL}#{unapproved_request.id}").to_return(status: 200)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("Successfully approved request")
    end

    it "for an unauthorized request" do
      stub_request(:post, "#{BASE_API_URL}#{unapproved_request.id}").to_return(status: 401)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("unauthorized")
    end

    it "for a not-found request" do
      stub_request(:post, "#{BASE_API_URL}#{unapproved_request.id}").to_return(status: 404)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("not-found")
    end

    it "for any other kind of request" do
      stub_request(:post, "#{BASE_API_URL}#{unapproved_request.id}").to_return(status: 999)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("unknown-error")
    end
  end
end
