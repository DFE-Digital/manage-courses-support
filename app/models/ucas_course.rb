class UcasCourse < ApplicationRecord
  self.table_name = "ucas_course"
  self.primary_key = "crse_code"

  belongs_to :institution,
    foreign_key: :inst_code
end
