class EmailedAccessRequest
  include ActiveModel::Model

  attr_reader :requester_email, :target_email, :first_name, :last_name

  def requester_email=(new_value)
    @requester_email = new_value.strip
  end

  def target_email=(new_value)
    @target_email = new_value.strip
  end

  def first_name=(new_value)
    @first_name = new_value.strip
  end

  def last_name=(new_value)
    @last_name = new_value.strip
  end

  def manually_approve!
    MANAGE_COURSES_API_SERVICE.manually_approve_access_request(
      requester_email: requester_email,
      target_email: target_email,
      first_name: first_name,
      last_name: last_name,
    )
  end
end
