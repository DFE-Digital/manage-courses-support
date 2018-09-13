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

    trait :god_user do
      email { "#{first_name}.#{last_name}@digital.education.gov.uk".downcase }
    end
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
    sequence(:inst_code) { |n| "A#{n}" }

    transient do
      course_count { 2 }
    end

    after(:create) do |institution, evaluator|
      create_list(:ucas_course, evaluator.course_count, institution: institution)
    end
  end

  factory :ucas_course do
    sequence(:crse_code) { |n| "C#{n}D3" }
  end

  factory :nctl_organisation do
    nctl_id { rand(1000000).to_s }
  end

  trait :draft do
    status { 0 }
  end

  trait :published do
    status { 1 }
  end

  factory :institution_enrichment do
    institution
  end

  factory :course_enrichment do
    institution
  end
end
