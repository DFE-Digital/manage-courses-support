class InstitutionEnrichment < ApplicationRecord
  self.table_name = "institution_enrichment"
  self.primary_key = "inst_code"

  enum status: { draft: 0, published: 1 }

  belongs_to :institution,
    foreign_key: :inst_code,
    primary_key: :inst_code
end
