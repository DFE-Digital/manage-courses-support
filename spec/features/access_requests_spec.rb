require "rails_helper"

describe "Access requests", type: :feature do
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

      within("header") do
        expect(page).to have_text("Access requests (1)")
      end

      expect(page).to have_text("Open access requests (1)")

      expect(page).to have_text("Jane")
      expect(page).to have_text("Smith")
      expect(page).not_to have_text("Leslie")
      expect(page).not_to have_text("Jones")
    end
  end

  describe "approving form access requests" do
    it "confirms success when the API call succeeds" do
      manage_backend_request = stub_api_v2_request "/access_requests/#{unapproved_request.id}/approve", nil, :post

      visit "/access-requests"
      click_button "Approve"

      expect(page).to have_text("Successfully approved request")
      expect(manage_backend_request).to have_been_made
      expect(page).to have_text("Inform the publisher")
      expect(page).to have_text("send an email to jane.smith@acme-scitt.org")

      click_link "Return to access requests"

      expect(page).to have_text("Open access requests")
    end

    it "shows an error when the API call returns 401" do
      stub_api_v2_request "/access_requests/#{unapproved_request.id}/approve", nil, :post, 401

      visit "/access-requests"
      click_button "Approve"

      expect(page).to have_text("JsonApiClient::Errors::NotAuthorized")
    end

    it "shows an error when the API call returns 404" do
      stub_api_v2_request "/access_requests/#{unapproved_request.id}/approve", nil, :post, 404

      visit "/access-requests"
      click_button "Approve"

      expect(page).to have_text("Couldn't find resource at")
    end

    it "shows an error when the API call returns an unexpected status code" do
      stub_api_v2_request "/access_requests/#{unapproved_request.id}/approve", nil, :post, 999

      visit "/access-requests"
      click_button "Approve"

      expect(page).to have_text("Unexpected response status: 999")
    end
  end

  describe "actioning emailed access requests" do
    before do
      FactoryBot.create(:userdb,
                        email: 'requester@email.com',
                        organisations: [
                          FactoryBot.create(:organisation, name: 'Org A'),
                          FactoryBot.create(:organisation, name: 'Org B'),
                        ])
    end

    let(:create_json_response) {
      {
        "data" =>
          [{ "id" => "1",
            "type" => "access_request",
            "attributes" =>
             { "email_address" => "andrew@brakus.biz",
              "first_name" => "Gaylord",
              "last_name" => "Torphy",
              "organisation" => "#<Organisation:0x00007fa23e159360>",
              "reason" => "Qui sequi culpa illo.",
              "requester_id" => 1,
              "status" => "requested",
              "requester_email" => "hoyt@beer.net",
              "request_date_utc" => "2019-05-20T13:17:32Z" },
            "relationships" => { "requester" => { "meta" => { "included" => false } } } },
           { "id" => "2",
            "type" => "access_request",
            "attributes" =>
             { "email_address" => "freddiecrona@shields.biz",
              "first_name" => "Emmett",
              "last_name" => "Murphy",
              "organisation" => "#<Organisation:0x00007fa246631060>",
              "reason" => "Animi aperiam occaecati et.",
              "requester_id" => 2,
              "status" => "requested",
              "requester_email" => "steven@stracke.net",
              "request_date_utc" => "2019-05-20T13:17:32Z" },
            "relationships" => { "requester" => { "meta" => { "included" => false } } } }],
        "jsonapi" => { "version" => "1.0" }
      }
    }

    it "previews the change, calls the API and confirms success when the request is valid" do
      manage_backend_create_request = stub_api_v2_request "/access_requests", create_json_response, :post
      manage_backend_approve_request = stub_api_v2_request "/access_requests/1/approve", nil, :post
      visit '/access-requests'

      click_link 'Create and approve an access request manually'
      expect(page).to have_text('Create access request')

      fill_in 'Requester email', with: 'requester@email.com'
      fill_in 'Target email', with: 'target@email.com'
      fill_in 'First name', with: 'first'
      fill_in 'Last name', with: 'last'

      click_button 'Preview'

      expect(page).to have_text('Approve new access for first last')
      expect(page).to have_text('first last <target@email.com>')
      expect(page).to have_text('Org A')
      expect(page).to have_text('Org B')

      click_button 'Approve'

      expect(page).to have_text('Successfully approved request')
      expect(manage_backend_create_request).to have_been_made
      expect(manage_backend_approve_request).to have_been_made
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
  end
end
