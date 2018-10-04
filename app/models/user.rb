class User < ApplicationRecord
  self.table_name = "mc_user"
  self.primary_key = "email"

  has_and_belongs_to_many :organisations,
    join_table: :mc_organisation_user,
    association_foreign_key: :org_id,
    foreign_key: :email

  def full_name
    [first_name, last_name].join(" ")
  end
end
