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

Organisation.create!(
  name: 'Acme',
  org_id: '12345',
  institutions: [
    Institution.create!(inst_full: 'Acme SCITT', inst_code: 'A01'),
    Institution.create!(inst_full: 'Acme Alliance', inst_code: 'A02'),
  ],
  users: [
    User.create!(first_name: 'Jane', last_name: 'Able', email: 'jable@acme-scitt.org'),
    admin_user,
  ],
)

Organisation.create!(
  name: 'Big Uni',
  org_id: '67890',
  institutions: [
    Institution.create!(inst_full: 'Big Uni', inst_code: 'B01'),
  ],
  users: [
    User.create!(first_name: 'Alex', last_name: 'Cryer', email: 'acryer@big-uni.ac.uk'),
    User.create!(first_name: 'Ben', last_name: 'Dobbs', email: 'bdobbs@big-uni.ac.uk'),
    User.create!(first_name: 'Carol', last_name: 'Eames', email: 'ceames@big-uni.ac.uk'),
    admin_user,
  ],
)

AccessRequest.create!(
  email_address: 'new.user@acme-scitt.org',
  first_name: 'New',
  last_name: 'User',
  requester_email: 'jable@acme-scitt.org',
  request_date_utc: Time.now - 1.week,
  status: 0,
)

AccessRequest.create!(
  email_address: 'another.new.user@acme-scitt.org',
  first_name: 'Another new',
  last_name: 'User',
  requester_email: 'jable@acme-scitt.org',
  request_date_utc: Time.now - 2.weeks,
  status: 1,
)
