require "rails_helper"

RSpec.describe "Organisations", type: :feature do
  include_context 'when authenticated'

  before do
    allow(Settings.publish).to(receive(:base_url)).and_return("https://example.org")
  end

  context "when accessing #index" do
    it "lists all organisations with their associated users and UCAS providers" do
      FactoryBot.create(:organisation,
                        name: "Stellar Alliance / Stellar SCITT",
                        org_id: '12345',
                        nctl_organisations_count: 0,
                        userdbs: [
                          FactoryBot.create(:userdb,
                                            email: 'awatson@stellar.org',
                                            first_name: 'Alice',
                                            last_name: 'Watson'),
                          FactoryBot.create(:userdb,
                                            email: 'bsmith@stellar.org',
                                            first_name: 'Betty',
                                            last_name: 'Smith',
                                            sign_in_user_id: 'a-uuid'),
                        ],
                        providers: [
                          FactoryBot.create(:provider,
                                            provider_name: 'Stellar Alliance',
                                            provider_code: 'S01'),
                          FactoryBot.create(:provider,
                                            provider_name: 'Stellar SCITT',
                                            provider_code: 'S02'),
                        ])

      FactoryBot.create(:nctl_organisation,
                        nctl_id: '1357',
                        organisation: Organisation.find_by(org_id: '12345'))
      FactoryBot.create(:nctl_organisation,
                        nctl_id: '2468',
                        organisation: Organisation.find_by(org_id: '12345'))

      FactoryBot.create(:organisation,
                        name: "University of Duncree",
                        org_id: '67890',
                        userdbs: [
                          FactoryBot.create(:userdb,
                                            email: 'jbrady@duncree.ac.uk',
                                            first_name: 'James',
                                            last_name: 'Brady')
                        ],
                        providers: [
                          FactoryBot.create(:provider,
                                            provider_name: 'University of Duncree',
                                            provider_code: 'D07')
                        ])

      visit "/organisations"

      within "#organisation12345" do
        expect(page).to have_text("Stellar Alliance / Stellar SCITT")
        expect(page).to have_text("NCTL IDs: 1357, 2468")
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
          href: "https://example.org/organisation/d07"
        )
      end
    end

    it "filters out internal DfE admin users who may be added to the org" do
      FactoryBot.create(:organisation,
                        name: "University of Duncree",
                        org_id: '67890',
                        userdbs: [
                          FactoryBot.create(:userdb,
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

  context "when accessing #index_without_active_users" do
    it "lists only organisations without active users" do
      FactoryBot.create(:organisation,
                        name: "Stellar Alliance / Stellar SCITT",
                        userdbs: [
                          FactoryBot.create(:userdb, :inactive),
                          FactoryBot.create(:userdb, :active)
                        ])

      FactoryBot.create(:organisation,
                        name: "University of Duncree",
                        org_id: '67890',
                        userdbs: [
                          FactoryBot.create(:userdb, :inactive,
                                            email: 'jbrady@duncree.ac.uk',
                                            first_name: 'James',
                                            last_name: 'Brady')
                        ],
                        providers: [
                          FactoryBot.create(:provider,
                                            provider_name: 'University of Duncree',
                                            provider_code: 'D07')
                        ])

      visit "/organisations/without-active-users"

      expect(page).not_to have_text("Stellar Alliance / Stellar SCITT")

      within "#organisation67890" do
        expect(page).to have_text("James Brady <jbrady@duncree.ac.uk>")
        expect(page).to have_text("University of Duncree [D07]")
      end
    end
  end
end
