class Course < ApplicationRecord
  self.table_name = "course"

  belongs_to :provider
end
