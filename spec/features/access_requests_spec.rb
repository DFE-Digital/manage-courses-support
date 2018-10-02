require "rails_helper"

BASE_API_URL = "https://www.example.com".freeze

RSpec.describe "Access requests", type: :feature do
  include_context 'when authenticated'

  let!(:unapproved_request) {
    FactoryBot.create(:access_request, :unapproved,
      first_name: "Jane",
      last_name: "Smith",
      email_address: 'jane.smith@acme-scitt.org')
  }

  describe "index" do
    it "shows only unapproved requests" do
      FactoryBot.create(:access_request, :approved,
        first_name: "Leslie",
        last_name: "Jones")

      visit "/access-requests"

      expect(page).to have_text("Jane")
      expect(page).to have_text("Smith")
      expect(page).not_to have_text("Leslie")
      expect(page).not_to have_text("Jones")
    end
  end

  describe "approving form access requests" do
    it "confirms success when the API call succeeds" do
      manage_courses_api_request = stub_request(:post, "#{BASE_API_URL}/api/admin/access-request?accessRequestId=#{unapproved_request.id}").to_return(status: 200)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("Successfully approved request")
      expect(manage_courses_api_request).to have_been_made
      expect(page).to have_text("Inform the publisher")
      expect(page).to have_text("send an email to jane.smith@acme-scitt.org")

      click_link "Return to access requests"

      expect(page).to have_text("Open access requests")
    end

    it "shows an error when the API call returns 401" do
      stub_request(:post, "#{BASE_API_URL}/api/admin/access-request?accessRequestId=#{unapproved_request.id}").to_return(status: 401)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("API client is unauthorized")
    end

    it "shows an error when the API call returns 404" do
      stub_request(:post, "#{BASE_API_URL}/api/admin/access-request?accessRequestId=#{unapproved_request.id}").to_return(status: 404)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("access request or the requester email not found")
    end

    it "shows an error when the API call returns an unexpected status code" do
      stub_request(:post, "#{BASE_API_URL}/api/admin/access-request?accessRequestId=#{unapproved_request.id}").to_return(status: 999)

      visit "/access-requests"
      click_link "Approve"

      expect(page).to have_text("unexpected response code 999")
    end
  end

  describe "actioning emailed access requests" do
    before do
      FactoryBot.create(:user, email: 'requester@email.com')
    end

    it "confirms success when the API call succeeds" do
      manage_courses_api_request = stub_request(:post, "#{BASE_API_URL}/api/admin/manual-access-request")
        .with(query: {
          requesterEmail: 'requester@email.com',
          targetEmail: 'target@email.com',
          firstName: 'first',
          lastName: 'last'
        })
        .to_return(status: 200)

      visit '/access-requests'

      click_link 'Create and approve an access request manually'
      expect(page).to have_text('Create access request')

      fill_in 'Requester email', with: 'requester@email.com'
      fill_in 'Target email', with: 'target@email.com'
      fill_in 'First name', with: 'first'
      fill_in 'Last name', with: 'last'

      click_button 'Preview'

      expect(page).to have_text('Preview access request')
      expect(page).to have_text('requester@email.com')
      expect(page).to have_text('first last <target@email.com>')

      click_button 'Approve'

      expect(page).to have_text('Successfully approved request')
      expect(manage_courses_api_request).to have_been_made
      expect(page).to have_text("Inform the publisher")
      expect(page).to have_text("send an email to target@email.com")

      click_link "Return to access requests"

      expect(page).to have_text("Open access requests")
    end

    it "stops the user support agent from proceeding if the requester email doesn't exist" do
      visit '/access-requests'

      click_link 'Create and approve an access request manually'

      fill_in 'Requester email', with: 'nonexistent@email.com'
      fill_in 'Target email', with: 'target@email.com'
      fill_in 'First name', with: 'first'
      fill_in 'Last name', with: 'last'

      click_button 'Preview'

      expect(page).to have_text("There is a problem")
      expect(page).to have_text("Enter the email of somebody already in the system")
    end

    it "stops the user support agent from entering blank fields" do
      visit '/access-requests'

      click_link 'Create and approve an access request manually'
      click_button 'Preview'

      expect(page).to have_text("There is a problem")
      expect(page).to have_text("Enter the email of someone already in the system")
      expect(page).to have_text("Enter the email of the person who needs access")
      expect(page).to have_text("Enter the first name of the person who needs access")
      expect(page).to have_text("Enter the last name of the person who needs access")
    end

    it "informs the user support agent when the API call fails" do
      manage_courses_api_request = stub_request(:post, %r{#{BASE_API_URL}/api/admin/manual-access-request})
        .to_return(status: 503)

      visit '/access-requests'

      click_link 'Create and approve an access request manually'

      fill_in 'Requester email', with: 'requester@email.com'
      fill_in 'Target email', with: 'target@email.com'
      fill_in 'First name', with: 'first'
      fill_in 'Last name', with: 'last'

      click_button 'Preview'
      click_button 'Approve'

      expect(manage_courses_api_request).to have_been_made
      expect(page).to have_text("Problem approving request")
    end
  end
end
