class Course < ApplicationRecord
  self.table_name = "course"

  belongs_to :provider
  has_and_belongs_to_many :sites
end
