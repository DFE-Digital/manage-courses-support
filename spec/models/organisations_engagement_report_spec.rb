require 'rails_helper'

describe OrganisationsEngagementReport, type: :model do
  let!(:orgs) { FactoryBot.create_list(:organisation, 5, nctl_organisations_count: 1) }
  let(:report) { OrganisationsEngagementReport.new.tap(&:run) }

  it "tracks the number of organisations with allocations" do
    expect(report[:orgs_with_allocations]).to eq(5)
  end

  it "tracks the number of organisations with UCAS courses" do
    institutions = FactoryBot.create_list(:institution, 4, course_count: 2)

    # attach institutions to orgs
    orgs[0..3].zip(institutions) do |org, institution|
      org.institutions << institution
    end

    expect(report[:orgs_with_ucas_courses]).to eq(4)
  end

  it "tracks the number of organisations with active, external users" do
    users = FactoryBot.create_list(:user, 3, :active)
    god_user = FactoryBot.create(:user, :god_user, :active)

    # attach users to orgs
    orgs[0..2].zip(users) do |org, user|
      org.users << user
      org.users << god_user
    end

    expect(report[:orgs_with_active_users]).to eq(3)
  end

  it "tracks the number of organisations with started and published institution enrichments" do
    institutions = FactoryBot.create_list(:institution, 2, course_count: 1)

    # attach institutions to orgs
    orgs[0..1].zip(institutions) do |org, institution|
      org.institutions << institution
    end

    FactoryBot.create(:institution_enrichment, :draft, institution: institutions[0])
    FactoryBot.create(:institution_enrichment, :published, institution: institutions[0])
    FactoryBot.create(:institution_enrichment, :draft, institution: institutions[1])

    expect(report[:orgs_with_started_inst_enrichments]).to eq(2)
    expect(report[:orgs_with_published_inst_enrichments]).to eq(1)
  end

  it "tracks the number of organisations with started and published course enrichments" do
    institutions = FactoryBot.create_list(:institution, 2, course_count: 1)

    # attach institutions to orgs
    orgs[0..1].zip(institutions) do |org, institution|
      org.institutions << institution
    end

    FactoryBot.create(:course_enrichment, :draft, institution: institutions[0])
    FactoryBot.create(:course_enrichment, :published, institution: institutions[0])
    FactoryBot.create(:course_enrichment, :draft, institution: institutions[1])

    expect(report[:orgs_with_started_course_enrichments]).to eq(2)
    expect(report[:orgs_with_published_course_enrichments]).to eq(1)
  end
end
