require "rails_helper"

RSpec.describe "Access requests", type: :feature do
  include_context 'when authenticated'

  it "Index contains only unapproved requests" do
    FactoryBot.create(:access_request, :unapproved,
      first_name: "Jane",
      last_name: "Smith")

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
