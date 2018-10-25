class Organisation < ApplicationRecord
  self.table_name = "organisation"

  ADMIN_EMAIL_DOMAIN = "education.gov.uk".freeze

  has_and_belongs_to_many :users, -> { where('"user".email not like ?', "%#{ADMIN_EMAIL_DOMAIN}") },
    join_table: :organisation_user

  has_and_belongs_to_many :institutions,
    join_table: :organisation_institution

  has_many :nctl_organisations

  def nctl_ids
    nctl_organisations.map(&:nctl_id)
  end
end
