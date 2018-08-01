class Institution < ApplicationRecord
  self.table_name = "ucas_institution"
  self.primary_key = "inst_code"
end
