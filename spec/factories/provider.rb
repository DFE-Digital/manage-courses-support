FactoryBot.define do
  factory :provider do
    provider_name { "ACME SCITT" + rand(1000000).to_s }
    sequence(:provider_code) { |n| "A#{n}" }
  end
end
