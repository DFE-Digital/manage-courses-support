class Institution < ApplicationRecord
  self.table_name = "institution"

  has_and_belongs_to_many :organisations,
    join_table: :organisation_institution

  has_many :courses,
    foreign_key: :inst_code
end
