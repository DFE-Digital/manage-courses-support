class AccessRequest < ApplicationRecord
  self.table_name = "access_request"

  belongs_to :requester, class_name: 'User', foreign_key: :requester_email, primary_key: :email
  scope :unapproved, -> { where(status: 0) }

  def recipient
    User.new(
      first_name: self.first_name,
      last_name: self.last_name,
      email: self.email_address,
    )
  end

  def approve!
    api_result = MANAGE_COURSES_API_SERVICE.approve_access_request(id)
    api_result
  end
end
