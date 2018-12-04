class Course < ApplicationRecord
  self.table_name = "course"

  belongs_to :provider
  belongs_to :accrediting_provider, class_name: 'Provider', optional: true
  has_many :site_statuses
  has_many :sites, through: :site_statuses
  has_and_belongs_to_many :subjects
end
