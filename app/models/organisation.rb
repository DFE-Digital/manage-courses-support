class Organisation < ApplicationRecord
  self.table_name = "mc_organisation"
  self.primary_key = "org_id"

  has_and_belongs_to_many :users,
    join_table: :mc_organisation_user,
    foreign_key: :org_id,
    association_foreign_key: :email
end
