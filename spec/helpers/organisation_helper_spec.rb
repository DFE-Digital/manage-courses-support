# frozen_string_literal: true

require 'rails_helper'

describe OrganisationHelper do
  describe '#user_details' do
    it 'returns the name and email' do
      user = FactoryBot.create(:user,
                               first_name: 'Jane',
                               last_name: 'Smith',
                               email: 'jsmith@acme-scitt.org')

      expect(helper.user_details(user)).to eq('Jane Smith <jsmith@acme-scitt.org>')
    end

    it 'deep-links to DfE Sign-in if the sign_in_user_id is set' do
      user = FactoryBot.create(:user,
                               first_name: 'Jane',
                               last_name: 'Smith',
                               email: 'jsmith@acme-scitt.org',
                               sign_in_user_id: 'a-uuid')

      expect(helper.user_details(user, dfe_signin_deeplink: true)).to eq(
        '<a href="https://support.signin.education.gov.uk/users/a-uuid/audit">Jane Smith &lt;jsmith@acme-scitt.org&gt;</a>'
      )
    end
  end
end
