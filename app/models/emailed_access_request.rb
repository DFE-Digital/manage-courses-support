# frozen_string_literal: true

class EmailedAccessRequest
  include ActiveModel::Model

  attr_reader :requester_email, :target_email, :first_name, :last_name

  validates :requester_email, presence: { message: 'Enter the email of someone already in the system' }
  validates :target_email, presence: { message: 'Enter the email of the person who needs access' }
  validates :first_name, presence: { message: 'Enter the first name of the person who needs access' }
  validates :last_name, presence: { message: 'Enter the last name of the person who needs access' }

  validate :requester_exists,
           unless: proc { |r| r.requester_email.blank? }

  def requester_email=(new_value)
    @requester_email = new_value.strip
  end

  def target_email=(new_value)
    @target_email = new_value.strip.downcase
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

  def recipient
    User
      .where(email: target_email)
      .first_or_initialize(first_name: first_name, last_name: last_name)
  end

  def new_organisations_granted
    requester.organisations - recipient.organisations
  end

  def manually_approve!
    MANAGE_COURSES_API.manually_approve_access_request(
      requester_email: requester_email,
      target_email: target_email,
      first_name: first_name,
      last_name: last_name
    )
  end

  private

  def requester_exists
    unless requester.present?
      errors.add(:requester_email, 'Enter the email of somebody already in the system')
    end
  end
end
