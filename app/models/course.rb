class Course < ApplicationRecord
  self.table_name = "course"

  belongs_to :provider
  has_many :site_statuses
  has_many :sites, through: :site_statuses
end
