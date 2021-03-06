class Userdb < ApplicationRecord
  self.table_name = "user"

  has_and_belongs_to_many :organisations,
                          join_table: :organisation_user,
                          foreign_key: :user_id

  def full_name
    [first_name, last_name].join(" ")
  end
end
