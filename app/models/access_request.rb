class AccessRequest < ApplicationRecord
  self.table_name = "access_request"

  belongs_to :requester, class_name: 'User', foreign_key: :requester_email, primary_key: :email
  scope :unapproved, -> { where(status: 0) }
end
