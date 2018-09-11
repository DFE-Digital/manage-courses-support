require "rails_helper"

describe OrganisationHelper do
  describe "#user_details" do
    it "returns the name and email" do
      user = FactoryBot.create(:user,
        first_name: 'Jane',
        last_name: 'Smith',
        email: 'jsmith@acme-scitt.org')

      expect(helper.user_details(user)).to eq('Jane Smith <jsmith@acme-scitt.org>')
    end
  end
end
