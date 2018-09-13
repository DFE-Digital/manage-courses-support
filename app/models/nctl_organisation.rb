class NctlOrganisation < ApplicationRecord
  self.table_name = "nctl_organisation"
  self.primary_key = "nctl_id"

  belongs_to :organisation,
    foreign_key: :org_id
end
