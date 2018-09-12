require 'rails_helper'

describe OrganisationsEngagementReport, type: :model do
  let(:report) { OrganisationsEngagementReport.new.tap(&:run) }

  before do
    FactoryBot.create_list(:organisation, 5, nctl_organisations_count: 1)
  end

  it "tracks the number of organisations with allocations" do
    expect(report[:orgs_with_allocations]).to eq(5)
  end
end
