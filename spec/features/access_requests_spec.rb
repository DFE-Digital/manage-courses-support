require "rails_helper"

RSpec.feature "Access requests", type: :feature do
  include_context 'when authenticated'

  scenario "Index contains only unapproved requests" do
    FactoryBot.create(:access_request, :unapproved,
      first_name: "Jane",
      last_name: "Smith",
    )

    FactoryBot.create(:access_request, :approved,
      first_name: "Leslie",
      last_name: "Jones",
    )

    visit "/access-requests"

    expect(page).to have_text("Jane")
    expect(page).to have_text("Smith")
    expect(page).to_not have_text("Leslie")
    expect(page).to_not have_text("Jones")
  end
end
