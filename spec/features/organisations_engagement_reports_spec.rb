# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organisations engagement report', type: :feature do
  include_context 'when authenticated'

  it 'the number of orgs with allocations' do
    FactoryBot.create_list(:organisation, 5, nctl_organisations_count: 1)

    visit '/'

    expect(page).to have_text('5 organisations with allocations')
    # this is mostly a smoke test - the report spec comprehensively tests the report logic
  end
end
