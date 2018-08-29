FactoryBot.define do
  factory :access_request do
    first_name { "Jane" }
    last_name  { "Smoth" }
    email_address { "#{first_name}.#{last_name}@acme-scitt.org".downcase }
    organisation { 'Acme SCITT' }
    requester_email { 'headmaster@acme-scitt.org' }
    request_date_utc { DateTime.parse('12 July 2018 12:00:00') }
    reason { "Jane Smith is the ITT course administrator" }
    status { 0 }

    trait :approved do
      status { 1 }
    end

    trait :unapproved do
      status { 0 }
    end
  end
end
