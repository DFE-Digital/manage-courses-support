require "rails_helper"

BASE_API_URL = "https://www.example.com".freeze

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
      manage_courses_api_request = stub_request(:post, "#{BASE_API_URL}/api/admin/access-request?accessRequestId=#{unapproved_request.id}").to_return(status: 200)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("Successfully approved request")
      expect(manage_courses_api_request).to have_been_made
    end

    it "for an unauthorized request" do
      stub_request(:post, "#{BASE_API_URL}/api/admin/access-request?accessRequestId=#{unapproved_request.id}").to_return(status: 401)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("unauthorized")
    end

    it "for a not-found request" do
      stub_request(:post, "#{BASE_API_URL}/api/admin/access-request?accessRequestId=#{unapproved_request.id}").to_return(status: 404)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("not-found")
    end

    it "for any other kind of request" do
      stub_request(:post, "#{BASE_API_URL}/api/admin/access-request?accessRequestId=#{unapproved_request.id}").to_return(status: 999)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("unknown-error")
    end
  end

  describe 'allows submitting manual access requests' do
    it 'displays link to create manual access requests' do
      LINK_TEXT = 'Create and approve an access request manually'.freeze
      visit '/access-requests'

      expect(page).to have_text(LINK_TEXT)
      click_link LINK_TEXT

      expect(page).to have_text('Create access request')
    end

    it 'allows submitting access requests' do
      manage_courses_api_request = stub_request(:post, "#{BASE_API_URL}/api/admin/manual-access-request")
        .with(query: {
          requesterEmail: 'requester@email.com',
          targetEmail: 'target@email.com',
          firstName: 'first',
          lastName: 'last'
        })
        .to_return(status: 200)

      visit '/access-requests/create'

      fill_in 'requester_email', with: 'requester@email.com'
      fill_in 'target_email', with: 'target@email.com'
      fill_in 'first_name', with: 'first'
      fill_in 'last_name', with: 'last'

      click_button 'Preview'

      expect(page).to have_text('Preview access request')
      expect(page).to have_text('requester@email.com')
      expect(page).to have_text('target@email.com')
      expect(page).to have_text('first')
      expect(page).to have_text('last')

      click_button 'Approve'

      expect(page).to have_text('Successfully approved request')
      expect(manage_courses_api_request).to have_been_made
    end
  end
end
