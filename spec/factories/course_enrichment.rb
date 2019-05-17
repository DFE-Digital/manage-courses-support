FactoryBot.define do
  factory :course_enrichment do
    provider

    trait :draft do
      status { 0 }
    end

    trait :published do
      status { 1 }
    end
  end
end
