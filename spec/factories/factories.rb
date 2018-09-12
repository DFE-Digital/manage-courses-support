FactoryBot.define do
  factory :user do
    first_name { "Jane" }
    last_name  { "Smoth" }
    email { "#{first_name}.#{last_name}@acme-scitt.org".downcase }
    sign_in_user_id { SecureRandom.uuid }
    welcome_email_date_utc { rand(100).days.ago }
  end

  factory :access_request do
    first_name { "Jane" }
    last_name  { "Smoth" }
    email_address { "#{first_name}.#{last_name}@acme-scitt.org".downcase }
    organisation { 'Acme SCITT' }
    association :requester, factory: :user
    request_date_utc { Time.parse('12 July 2018 12:00:00') }
    reason { "Jane Smith is the ITT course administrator" }
    status { 0 }

    trait :approved do
      status { 1 }
    end

    trait :unapproved do
      status { 0 }
    end
  end

  factory :organisation do
    name  { 'ACME SCITT' }
    org_id { rand(1000000).to_s }

    transient do
      nctl_organisations_count { 1 }
    end

    after(:create) do |organisation, evaluator|
      create_list(:nctl_organisation, evaluator.nctl_organisations_count, organisation: organisation)
    end
  end

  factory :institution do
    inst_full { 'ACME SCITT' + rand(1000000).to_s }
    inst_code { 'A01' }
  end

  factory :nctl_organisation do
    nctl_id { rand(1000000).to_s }
  end
end
