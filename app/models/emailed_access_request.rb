class EmailedAccessRequest
  include ActiveModel::Model

  attr_accessor :requester_email, :target_email, :first_name, :last_name

  def manually_approve!
    MANAGE_COURSES_API_SERVICE.manually_approve_access_request(
      requester_email: requester_email,
      target_email: target_email,
      first_name: first_name,
      last_name: last_name,
    )
  end
end
