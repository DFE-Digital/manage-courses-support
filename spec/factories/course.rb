FactoryBot.define do
  factory :course do
    sequence(:course_code) { |n| "C#{n}D3" }
  end
end
