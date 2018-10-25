class Course < ApplicationRecord
  self.table_name = "course"
  self.primary_key = "course_code"

  belongs_to :institution
end
