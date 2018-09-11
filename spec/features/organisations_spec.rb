require "rails_helper"

RSpec.describe "Organisations index", type: :feature do
  include_context 'when authenticated'

  it "lists all organisations with their associated users and UCAS institutions" do
    FactoryBot.create(:organisation,
      name: "Stellar Alliance / Stellar SCITT",
      org_id: '12345',
      users: [
        FactoryBot.create(:user,
          email: 'awatson@stellar.org',
          first_name: 'Alice',
          last_name: 'Watson'),
        FactoryBot.create(:user,
          email: 'bsmith@stellar.org',
          first_name: 'Betty',
          last_name: 'Smith',
          sign_in_user_id: 'a-uuid'),
      ],
      institutions: [
        FactoryBot.create(:institution,
          inst_full: 'Stellar Alliance',
          inst_code: 'S01'),
        FactoryBot.create(:institution,
          inst_full: 'Stellar SCITT',
          inst_code: 'S02'),
      ])

    FactoryBot.create(:organisation,
      name: "University of Duncree",
      org_id: '67890',
      users: [
        FactoryBot.create(:user,
          email: 'jbrady@duncree.ac.uk',
          first_name: 'James',
          last_name: 'Brady')
      ],
      institutions: [
        FactoryBot.create(:institution,
          inst_full: 'University of Duncree',
          inst_code: 'D07')
      ])

    visit "/organisations"

    within "#organisation12345" do
      expect(page).to have_text("Alice Watson <awatson@stellar.org>")
      expect(page).to have_link(
        "Betty Smith <bsmith@stellar.org>",
        href: "https://support.signin.education.gov.uk/users/a-uuid/audit"
      )
      expect(page).to have_text("Stellar Alliance [S01]")
      expect(page).to have_text("Stellar SCITT [S02]")

      expect(page).not_to have_text("James Brady <jbrady@duncree.ac.uk>")
      expect(page).not_to have_text("University of Duncree [D07]")
    end

    within "#organisation67890" do
      expect(page).to have_text("James Brady <jbrady@duncree.ac.uk>")
      expect(page).to have_link(
        "University of Duncree [D07]",
        href: "https://publish-teacher-training-courses.education.gov.uk/organisation/d07"
      )
    end
  end

  it "filters out internal DfE admin users who may be added to the org" do
    FactoryBot.create(:organisation,
      name: "University of Duncree",
      org_id: '67890',
      users: [
        FactoryBot.create(:user,
          email: 'johnny.admin@education.gov.uk',
          first_name: 'Johnny',
          last_name: 'Admin')
      ])

    visit "/organisations"

    within "#organisation67890" do
      expect(page).not_to have_text("Johnny Admin")
    end
  end
end
