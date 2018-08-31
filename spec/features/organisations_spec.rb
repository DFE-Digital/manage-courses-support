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
          last_name: 'Smith'),
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
      expect(page).to have_text("Betty Smith <bsmith@stellar.org>")
      expect(page).to have_text("Stellar Alliance [S01]")
      expect(page).to have_text("Stellar SCITT [S02]")

      expect(page).not_to have_text("James Brady <jbrady@duncree.ac.uk>")
      expect(page).not_to have_text("University of Duncree [D07]")
    end

    within "#organisation67890" do
      expect(page).to have_text("James Brady <jbrady@duncree.ac.uk>")
      expect(page).to have_text("University of Duncree [D07]")
    end
  end
end
