class EmailedAccessRequest
  include ActiveModel::Model

  attr_reader :requester_email, :target_email, :first_name, :last_name

  validate :requester_exists,
    unless: Proc.new { |r| r.requester_email.blank? }

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

  def requester
    User.find_by(email: requester_email)
  end

  def manually_approve!
    MANAGE_COURSES_API.manually_approve_access_request(
      requester_email: requester_email,
      target_email: target_email,
      first_name: first_name,
      last_name: last_name,
    )
  end

private

  def requester_exists
    unless requester.present?
      errors.add(:requester_email, "Enter the email of somebody already in the system")
    end
  end
end
