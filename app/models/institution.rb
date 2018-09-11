class Institution < ApplicationRecord
  self.table_name = "ucas_institution"
  self.primary_key = "inst_code"

  has_and_belongs_to_many :organisations,
    join_table: :mc_organisation_institution,
    association_foreign_key: :org_id,
    foreign_key: :institution_code

  has_many :ucas_courses,
    foreign_key: :inst_code

  has_many :institution_enrichments,
    foreign_key: :inst_code
end
