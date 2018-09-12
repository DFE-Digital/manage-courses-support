require 'rails_helper'

describe OrganisationsEngagementReport, type: :model do
  let(:report) { OrganisationsEngagementReport.new.tap(&:run) }

  before do
    @orgs = FactoryBot.create_list(:organisation, 5, nctl_organisations_count: 1)
  end

  it "tracks the number of organisations with allocations" do
    expect(report[:orgs_with_allocations]).to eq(5)
  end

  it "tracks the number of organisations with UCAS courses" do
    institutions = FactoryBot.create_list(:institution, 4, course_count: 2)

    # attach institutions to orgs
    @orgs[0..3].zip(institutions) do |org, institution|
      org.institutions << institution
    end

    expect(report[:orgs_with_ucas_courses]).to eq(4)
  end
end
