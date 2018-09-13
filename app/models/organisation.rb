class Organisation < ApplicationRecord
  self.table_name = "mc_organisation"
  self.primary_key = "org_id"

  ADMIN_EMAIL_DOMAIN = "education.gov.uk".freeze

  has_and_belongs_to_many :users, -> { where("mc_user.email not like ?", "%#{ADMIN_EMAIL_DOMAIN}") },
    join_table: :mc_organisation_user,
    foreign_key: :org_id,
    association_foreign_key: :email

  has_and_belongs_to_many :institutions,
    join_table: :mc_organisation_institution,
    foreign_key: :org_id,
    association_foreign_key: :institution_code

  has_many :nctl_organisations,
    foreign_key: :org_id
end
