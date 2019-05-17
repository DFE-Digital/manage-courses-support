FactoryBot.define do
  factory :user do
    first_name { "Jane" }
    last_name  { "Smoth" }
    email { "#{first_name}.#{last_name}@acme-scitt.org".downcase }
    sign_in_user_id { SecureRandom.uuid }
    welcome_email_date_utc { rand(100).days.ago }

    trait :active do
      welcome_email_date_utc { rand(100).days.ago }
    end

    trait :inactive do
      welcome_email_date_utc { nil }
      sign_in_user_id { nil }
    end

    trait :god_user do
      email { "#{first_name}.#{last_name}@digital.education.gov.uk".downcase }
    end
  end
end
