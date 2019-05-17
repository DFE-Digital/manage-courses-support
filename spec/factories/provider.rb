FactoryBot.define do
  factory :provider do
    provider_name { 'ACME SCITT' + rand(1000000).to_s }
    sequence(:provider_code) { |n| "A#{n}" }

    transient do
      course_count { 2 }
    end

    after(:create) do |provider, evaluator|
      create_list(:course, evaluator.course_count, provider: provider)
    end
  end
end
