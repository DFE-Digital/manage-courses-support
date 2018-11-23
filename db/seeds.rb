# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_user = User.create!(
  first_name: 'Super',
  last_name: 'Admin',
  email: 'super.admin@education.gov.uk',
)

acme = Organisation.create!(
  name: 'Acme',
  org_id: '12345',
  providers: [
    Provider.create!(provider_name: 'Acme SCITT', provider_code: 'A01'),
    Provider.create!(provider_name: 'Acme Alliance', provider_code: 'A02'),
  ],
  users: [
    User.create!(
      first_name: 'Jane',
      last_name: 'Able',
      email: 'jable@acme-scitt.org',
      welcome_email_date_utc: 7.days.ago,
      sign_in_user_id: 'uuid',
    ),
    admin_user,
  ],
)

Course.create!(
  course_code: '3X1A',
  provider: Provider.find_by(provider_code: 'A01'),
)

Course.create!(
  course_code: '3X1B',
  provider: Provider.find_by(provider_code: 'A01'),
)

Course.create!(
  course_code: '5W2A',
  provider: Provider.find_by(provider_code: 'A02'),
)

ProviderEnrichment.create!(
  provider: Provider.find_by(provider_code: 'A01'),
  status: :published,
)

ProviderEnrichment.create!(
  provider: Provider.find_by(provider_code: 'A01'),
  status: :draft,
)

CourseEnrichment.create!(
  provider: Provider.find_by(provider_code: 'A01'),
  status: :draft,
)

CourseEnrichment.create!(
  provider: Provider.find_by(provider_code: 'A01'),
  status: :published,
)

NctlOrganisation.create!(
  organisation: acme,
  nctl_id: '123AAA',
)

big_uni = Organisation.create!(
  name: 'Big Uni',
  org_id: '67890',
  providers: [
    Provider.create!(provider_name: 'Big Uni', provider_code: 'B01'),
  ],
  users: [
    User.create!(first_name: 'Alex', last_name: 'Cryer', email: 'acryer@big-uni.ac.uk'),
    User.create!(first_name: 'Ben', last_name: 'Dobbs', email: 'bdobbs@big-uni.ac.uk'),
    User.create!(first_name: 'Carol', last_name: 'Eames', email: 'ceames@big-uni.ac.uk'),
    admin_user,
  ],
)

Course.create!(
  course_code: '9A5Y',
  provider: Provider.find_by(provider_code: 'B01'),
)

NctlOrganisation.create!(
  organisation: big_uni,
  nctl_id: '678BBB',
)

AccessRequest.create!(
  email_address: 'new.user@acme-scitt.org',
  first_name: 'New',
  last_name: 'User',
  requester_email: 'jable@acme-scitt.org',
  request_date_utc: Time.now - 1.week,
  status: :requested,
)

AccessRequest.create!(
  email_address: 'another.new.user@acme-scitt.org',
  first_name: 'Another new',
  last_name: 'User',
  requester_email: 'jable@acme-scitt.org',
  request_date_utc: Time.now - 2.weeks,
  status: :actioned,
)
