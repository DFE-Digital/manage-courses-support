FactoryBot.define do
  factory :organisation do
    name  { "ACME SCITT" }
    org_id { rand(1000000).to_s }

    transient do
      nctl_organisations_count { 1 }
    end

    after(:create) do |organisation, evaluator|
      create_list(:nctl_organisation, evaluator.nctl_organisations_count, organisation: organisation)
    end
  end
end
