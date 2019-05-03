# frozen_string_literal: true

require 'rails_helper'

describe OrganisationsEngagementReport, type: :model do
  let!(:orgs) { FactoryBot.create_list(:organisation, 5, nctl_organisations_count: 1) }
  let(:report) { OrganisationsEngagementReport.new.tap(&:run) }

  it 'tracks the number of organisations with allocations' do
    expect(report[:orgs_with_allocations]).to eq(5)
  end

  it 'tracks the number of organisations with UCAS courses' do
    providers = FactoryBot.create_list(:provider, 4, course_count: 2)

    # attach providers to orgs
    orgs[0..3].zip(providers) do |org, provider|
      org.providers << provider
    end

    expect(report[:orgs_with_ucas_courses]).to eq(4)
  end

  it 'tracks the number of organisations with active, external users' do
    users = FactoryBot.create_list(:user, 3, :active)
    god_user = FactoryBot.create(:user, :god_user, :active)

    # attach users to orgs
    orgs[0..2].zip(users) do |org, user|
      org.users << user
      org.users << god_user
    end

    expect(report[:orgs_with_active_users]).to eq(3)
  end

  it 'tracks the number of organisations with started and published provider enrichments' do
    providers = FactoryBot.create_list(:provider, 2, course_count: 1)

    # attach providers to orgs
    orgs[0..1].zip(providers) do |org, provider|
      org.providers << provider
    end

    FactoryBot.create(:provider_enrichment, :draft, provider: providers[0])
    FactoryBot.create(:provider_enrichment, :published, provider: providers[0])
    FactoryBot.create(:provider_enrichment, :draft, provider: providers[1])

    expect(report[:orgs_with_started_inst_enrichments]).to eq(2)
    expect(report[:orgs_with_published_inst_enrichments]).to eq(1)
  end

  it 'tracks the number of organisations with started and published course enrichments' do
    providers = FactoryBot.create_list(:provider, 2, course_count: 1)

    # attach providers to orgs
    orgs[0..1].zip(providers) do |org, provider|
      org.providers << provider
    end

    FactoryBot.create(:course_enrichment, :draft, provider: providers[0])
    FactoryBot.create(:course_enrichment, :published, provider: providers[0])
    FactoryBot.create(:course_enrichment, :draft, provider: providers[1])

    expect(report[:orgs_with_started_course_enrichments]).to eq(2)
    expect(report[:orgs_with_published_course_enrichments]).to eq(1)
  end
end
