class AccessRequest < ApplicationRecord
  self.table_name = "access_request"
  enum status: { requested: 0, approved: 1, actioned: 2 }

  belongs_to :requester, class_name: 'User', foreign_key: :requester_email, primary_key: :email
  scope :unapproved, -> { where(status: :requested) }

  def recipient
    User.new(
      first_name: self.first_name,
      last_name: self.last_name,
      email: self.email_address,
    )
  end

  def approve!
    MANAGE_COURSES_API.approve_access_request(id)
  end
end
