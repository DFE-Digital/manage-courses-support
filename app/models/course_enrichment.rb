class CourseEnrichment < ApplicationRecord
  self.table_name = "course_enrichment"
  self.primary_key = "inst_code"

  enum status: { draft: 0, published: 1 }

  belongs_to :institution,
    foreign_key: :inst_code
end
